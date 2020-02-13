//
//  ReviewRatingsView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ReviewRatingsView: View {

    private enum ImageNames: String {
        case filledStar = "star.fill"
        case star = "star"
    }

    let rating: Rating

    var body: some View {
        HStack {
            Group {
                ForEach( 0 ..< rating.rawValue, id: \.self ) { _ in
                    Image(systemName: ImageNames.filledStar.rawValue)
                }

                ForEach ( 0 ..< Rating.five.rawValue - rating.rawValue, id: \.self ) { _ in
                    Image(systemName: ImageNames.star.rawValue)
                }
            }
            .shadow(radius: 1)
            .foregroundColor(Color.yellow)
            Spacer()
        }
    }
}
