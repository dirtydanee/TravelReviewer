//
//  DateDisplayView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct DateDisplayView: View {

    let formattedDate: String

    var body: some View {
        HStack {
            Text(formattedDate)
                .font(.subheadline)
                .foregroundColor(Color.gray)
            Spacer()
        }
    }
}
