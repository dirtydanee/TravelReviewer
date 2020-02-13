//
//  NetworkingClient.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    var url: URL { get }
}

protocol NetworkingClient {
    func execute(request: NetworkRequest, completionHandler: @escaping (Result<Data, Swift.Error>) -> Void)
    func execute<Response: Decodable>(request: NetworkRequest, completionHandler: @escaping (Result<Response, Swift.Error>) -> Void)
    func cancelOnGoingTasks()
}
