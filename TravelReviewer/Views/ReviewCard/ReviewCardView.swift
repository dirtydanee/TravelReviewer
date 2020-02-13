//
//  ReviewCardView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ReviewCardView: View {

    let reviewCardViewModel: ReviewCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DateDisplayView(formattedDate: reviewCardViewModel.formattedDate)
            ReviewRatingsView(rating: reviewCardViewModel.rating)
            ReviewTextView(title: reviewCardViewModel.title, message: reviewCardViewModel.message)
            ProfileView(profilePictureViewModel: reviewCardViewModel.profileViewModel)
        }
    }
}
