//
//  ProfileInitialView.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import SwiftUI

struct ProfileInitialView: View {

    let initial: String
    let style: ProfileView.CircleStyle

    var body: some View {
           Circle()
               .overlay(
                Text(initial)
                       .font(.title)
                       .foregroundColor(Color.white))
               .foregroundColor(Color.red)
            .shadow(radius: style.shadowRadius)
            .frame(width: style.size.width, height: style.size.height)
       }
}
