//
//  ProfilePictureView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ProfilePictureView: View {

    @Binding private(set) var image: UIImage
    let style: ProfileView.CircleStyle

    var body: some View {
        Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(Circle())
            .shadow(radius: style.shadowRadius)
            .frame(width: style.size.width, height: style.size.height)
    }
}

