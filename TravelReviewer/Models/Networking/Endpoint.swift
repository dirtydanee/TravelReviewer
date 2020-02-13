//
//  Endpoint.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct Endpoint {

    enum Service: String {
        case travelers = "travelers-api.getyourguide.com"
        case photo = "cdn.getyourguide.com"
    }

    let service: Service
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = service.rawValue
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
