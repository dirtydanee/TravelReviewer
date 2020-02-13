//
//  SortingSpecifierView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct SortingSpecifierView: View {

    @Binding var ratingOrderSelection: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sort by rating")
                .font(.callout)
            Picker("", selection: $ratingOrderSelection) {
                ForEach ( 0 ..< Sorting.Order.allCases.count ) {
                    Text(Sorting.Order.allCases[$0].userInterfaceValue)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}
