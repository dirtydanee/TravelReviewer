//
//  ProfileView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    struct CircleStyle {
        let size: CGSize
        let shadowRadius: CGFloat

        static let `default` = CircleStyle(size: CGSize(width: 50, height: 50),
                                           shadowRadius: 3)
    }

    @ObservedObject private(set) var profilePictureViewModel: ProfilePictureViewModel

    var body: some View {
        HStack {
            if profilePictureViewModel.photoURL == nil {
                ProfileInitialView(initial: profilePictureViewModel.initials,
                                   style: CircleStyle.default)
            } else {
                ProfilePictureView(image: $profilePictureViewModel.image,
                                   style: CircleStyle.default)
                    .onAppear {
                        self.profilePictureViewModel.fetchPhoto()
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Reviewed by")
                Text(profilePictureViewModel.reviewFooterText)
            }.font(.footnote)
            Spacer()
        }
    }
}
