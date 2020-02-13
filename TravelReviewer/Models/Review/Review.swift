//
//  Review.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct Review: Decodable {
    let id: Int
    let author: Author
    let title: String
    let message: String
    let rating: Rating
    let created: Date
}
