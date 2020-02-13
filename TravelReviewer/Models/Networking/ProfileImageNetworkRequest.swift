//
//  ProfileImageNetworkRequest.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 13.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

struct ProfileImageNetworkRequest: NetworkRequest {

    let url: URL

    init(url: URL) {
        let endpoint = Endpoint(service: .photo, path: url.path, queryItems: [])
        self.url = endpoint.url!
    }
}
