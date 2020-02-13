//
//  NetworkingClientImpl.swift
//  TravelReviewer
//
//  Created by Daniel Metzing on 14.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import Foundation

final class NetworkingClientImpl: NetworkingClient {

    enum Error: Swift.Error {
        case invalidResponse
        case missingData
        case unsuccessfulResponse(Int)
        case decodingIssue(Swift.Error)
    }

    private var session: URLSession
    private let sessionConfiguration: URLSessionConfiguration
    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder, sessionConfiguration: URLSessionConfiguration) {
        self.jsonDecoder = jsonDecoder
        self.sessionConfiguration = sessionConfiguration
        self.session = URLSession(configuration: sessionConfiguration)
    }

    func cancelOnGoingTasks() {
        session.invalidateAndCancel()
        session = URLSession(configuration: sessionConfiguration)
    }

    func execute<Response: Decodable>(request: NetworkRequest, completionHandler: @escaping (Result<Response, Swift.Error>) -> Void) {

        executeDataTask(forRequest: request) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let response = try strongSelf.jsonDecoder.decode(Response.self, from: data)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(Error.decodingIssue(error)))
                }
            }
        }
    }

    func execute(request: NetworkRequest, completionHandler: @escaping (Result<Data, Swift.Error>) -> Void) {
        executeDataTask(forRequest: request, completionHandler: completionHandler)
    }

    private func executeDataTask(forRequest request: NetworkRequest, completionHandler: @escaping (Result<Data, Swift.Error>) -> Void) {
        let task = session.dataTask(with: request.url) { data, response, error in
            DispatchQueue.main.async {

                if let error = error {
                    completionHandler(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(Error.invalidResponse))
                    return
                }

                guard httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else {
                    completionHandler(.failure(Error.unsuccessfulResponse(httpResponse.statusCode)))
                    return
                }

                guard let data = data else {
                    completionHandler(.failure(Error.missingData))
                    return
                }

                completionHandler(.success(data))
            }
        }
        task.resume()
    }
}
