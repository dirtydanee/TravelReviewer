//
//  Author.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct Author: Decodable {
    let fullName: String
    let country: String?
    let photo: URL?
}
