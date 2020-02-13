//
//  ActivityIndicatorRowView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorRowView: View {

    @Binding private(set) var isVisible: Bool

    var body: some View {
        HStack {
            if self.isVisible {
                Spacer()
                ActivityIndicatorView(style: .medium)
                Spacer()
            } else {
                EmptyView()
            }
        }
    }
}
