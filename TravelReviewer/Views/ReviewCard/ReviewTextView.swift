//
//  ReviewTextView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ReviewTextView: View {

    let title: String?
    let message: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            title.map({
                Text($0)
                .font(.headline)
            })
            message.map({
                Text($0)
                .font(.body)
            })
        }
    }
}
