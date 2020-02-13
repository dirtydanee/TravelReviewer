//
//  ReviewCardViewModel.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct ReviewCardViewModel: Identifiable {

    var id: Int { review.id }

    private let dateFormatter: DateFormatter
    private let review: Review
    private let networkingClient: NetworkingClient

    let formattedDate: String
    let rating: Rating
    let title: String?
    let message: String?
    let profileViewModel: ProfilePictureViewModel

    init(review: Review, dateFormatter: DateFormatter, networkingClient: NetworkingClient) {
        self.review = review
        self.dateFormatter = dateFormatter
        self.rating = review.rating
        self.title = review.title.isEmpty ? nil : review.title
        self.message = review.message.isEmpty ? nil : review.message
        self.formattedDate = dateFormatter.string(from: review.created)
        self.networkingClient = networkingClient
        self.profileViewModel = ProfilePictureViewModel(networkingClient: networkingClient, author: review.author)
    }
}
