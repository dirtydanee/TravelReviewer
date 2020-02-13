//
//  ReviewsNetworkRequest.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct ReviewsNetworkRequest: NetworkRequest {

    let url: URL
    private let path = "/activities/23776/reviews"

    init(pagination: NetworkPagination, sortedBy: [Sorting], queryBuilder: QueryItemsBuilder) {
        let endpoint = Endpoint(service: .travelers,
                                path: path,
                                queryItems: queryBuilder.build(pagination: pagination, sortedBy: sortedBy))
        self.url = endpoint.url!
    }
}

extension ReviewsNetworkRequest {
    struct QueryItemsBuilder {
        func build(pagination: NetworkPagination, sortedBy: [Sorting]) -> [URLQueryItem] {
            let queryLimit = URLQueryItem(name: "limit", value: "\(pagination.limit)")
            let queryOffset = URLQueryItem(name: "offset", value: "\(pagination.offset)")
            let sortQueries = sortedBy.map { URLQueryItem(name: "sort", value: "\($0.key.rawValue):\($0.order.networkValue)") }
            return [queryLimit, queryOffset] + sortQueries
        }
    }
}
