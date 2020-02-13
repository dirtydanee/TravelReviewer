//
//  ReviewsListView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ReviewsListView: View {
    
    @ObservedObject private(set) var reviewListsViewModel: ReviewListsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: SortingSpecifierView(ratingOrderSelection: $reviewListsViewModel.ratingOrderSelection),
                        footer: ActivityIndicatorRowView(isVisible: $reviewListsViewModel.shouldDisplayLoadingIndicator)) {
                            ForEach(0 ..< reviewListsViewModel.elements.count, id: \.self) { index in
                                ReviewCardView(reviewCardViewModel: self.reviewListsViewModel.elements[index])
                                    .onAppear {
                                        if index == self.reviewListsViewModel.elements.count - 1 {
                                            self.reviewListsViewModel.didReachLastElementInList()
                                        }
                                }
                            }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Reviews"))
            .onAppear {
                self.reviewListsViewModel.viewAppeared()
            }
        }.alert(isPresented: $reviewListsViewModel.shouldShowNetworkErrorAlert) {
            Alert(title: Text("Something unexpected happened!"),
                  message: Text("Please try again later."),
                  dismissButton: .default(Text("Ok")))
        }
    }
}
