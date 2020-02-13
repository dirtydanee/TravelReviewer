//
//  ReviewListViewModel.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Combine
import Foundation

final class ReviewListsViewModel: ObservableObject {
    
    @Published var elements: [ReviewCardViewModel] = []
    @Published var shouldDisplayLoadingIndicator: Bool = false
    @Published var shouldShowNetworkErrorAlert: Bool = false
    @Published var ratingOrderSelection = Sorting.Order.descending.rawValue {
        didSet {
            elements = []
            networkingClient.cancelOnGoingTasks()
            isNetworkActivityOngoing = false
            loadElements()
        }
    }
    
    private var isNetworkActivityOngoing: Bool = false {
        didSet {
            isLoadingAdditionalReviews = isNetworkActivityOngoing
            shouldDisplayLoadingIndicator = isNetworkActivityOngoing
        }
    }
    
    private var isLoadingAdditionalReviews: Bool = false
    private let paginationLimit = 50
    private let networkingClient: NetworkingClient
    
    init(networkingClient: NetworkingClient) {
        self.networkingClient = networkingClient
    }
}

// MARK: - Public interface

extension ReviewListsViewModel {
    func didReachLastElementInList() {
        guard !isLoadingAdditionalReviews else {
            return
        }
        loadElements()
    }
    
    func viewAppeared() {
        loadElements()
    }
}

// MARK: - Private interface

private extension ReviewListsViewModel {
    
    func loadElements() {
        isNetworkActivityOngoing = true
        let request = ReviewsNetworkRequest(pagination: NetworkPagination(limit: paginationLimit, offset: elements.count),
                                            sortedBy: [Sorting(key: .date, order: .ascending),
                                                       Sorting(key: .rating, order: Sorting.Order.allCases[ratingOrderSelection])],
                                            queryBuilder: ReviewsNetworkRequest.QueryItemsBuilder())
        
        networkingClient.execute(request: request) { [weak self] (result: Result<ReviewsNetworkResponse, Swift.Error>) in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error as NSError):
                print("Unexpected error has occoured while fetching reviews. Error: \(error)")
                if error.code != NSURLErrorCancelled {
                    strongSelf.shouldShowNetworkErrorAlert = true
                }
            case .success(let response):
                    let viewModels = response.reviews.map { ReviewCardViewModel(review: $0,
                                                                                dateFormatter: .default,
                                                                                networkingClient: strongSelf.networkingClient) }
                    strongSelf.elements.append(contentsOf: viewModels)
            }
            strongSelf.isNetworkActivityOngoing = false
        }
    }
}
