//
//  ReviewsNetworkResponse.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct ReviewsNetworkResponse: Decodable {

    let reviews: [Review]
    let totalCount: Int
    let averageRating: Double
    let pagination: NetworkPagination
}

struct NetworkPagination: Decodable {

    let limit: Int
    let offset: Int
}
