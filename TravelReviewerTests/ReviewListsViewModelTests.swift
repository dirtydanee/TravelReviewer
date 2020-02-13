//
//  ReviewListsViewModelTests.swift
//  TravelReviewerTests
//
//  Created by Daniel Metzing on 12.02.20.
//  Copyright © 2020 Daniel Metzing. All rights reserved.
//

import XCTest
@testable import TravelReviewer

class ReviewListsViewModelTests: XCTestCase {

    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }

    override func tearDown() {
        decoder = nil
        super.tearDown()
    }

    func testViewModelDefaultState() {
        let networkingClient = MockNetworkingClient()
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)
        XCTAssertTrue(viewModel.elements.isEmpty)
        XCTAssertEqual(viewModel.ratingOrderSelection, Sorting.Order.descending.rawValue)
        XCTAssertFalse(viewModel.shouldDisplayLoadingIndicator)
        XCTAssertFalse(viewModel.shouldShowNetworkErrorAlert)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 0)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsOnViewAppearedWithSuccess() throws {
        let response = try decoder.decode(ReviewsNetworkResponse.self, from: Data(MockReviewResponseResource.value.utf8))
        let networkingClient = MockNetworkingClient(result: .success(response))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)
        let review = try decoder.decode(Review.self, from: Data(MockReviewResource.value.utf8))

        viewModel.viewAppeared()
        XCTAssertEqual(viewModel.elements.count, 1)
        XCTAssertEqual(viewModel.elements.first?.id, review.id)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 1)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsOnViewAppearedWithFailure() {
        let networkingClient = MockNetworkingClient(result: .failure(Error.mockError))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)

        viewModel.viewAppeared()
        XCTAssertEqual(viewModel.elements.count, 0)
        XCTAssertEqual(viewModel.shouldShowNetworkErrorAlert, true)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 1)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsOnViewAppearedWhenCancelled() {
        let networkingClient = MockNetworkingClient(result: .failure(NSError(domain: "tests", code: NSURLErrorCancelled, userInfo: nil)))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)

        viewModel.viewAppeared()
        XCTAssertEqual(viewModel.elements.count, 0)
        XCTAssertEqual(viewModel.shouldShowNetworkErrorAlert, false)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 1)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsOnReachingLastElementWithSuccess() throws {
        let response = try decoder.decode(ReviewsNetworkResponse.self, from: Data(MockReviewResponseResource.value.utf8))
        let networkingClient = MockNetworkingClient(result: .success(response))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)
        let review = try decoder.decode(Review.self, from: Data(MockReviewResource.value.utf8))

        viewModel.didReachLastElementInList()
        XCTAssertEqual(viewModel.elements.count, 1)
        XCTAssertEqual(viewModel.elements.first?.id, review.id)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 1)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsReachingLastElementWithFailure() {
        let networkingClient = MockNetworkingClient(result: .failure(Error.mockError))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)

        viewModel.didReachLastElementInList()
        XCTAssertEqual(viewModel.elements.count, 0)
        XCTAssertEqual(viewModel.shouldShowNetworkErrorAlert, true)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 1)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsReachingLastElementWhenCancelled() {
        let networkingClient = MockNetworkingClient(result: .failure(NSError(domain: "tests", code: NSURLErrorCancelled, userInfo: nil)))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)

        viewModel.didReachLastElementInList()
        XCTAssertEqual(viewModel.elements.count, 0)
        XCTAssertEqual(viewModel.shouldShowNetworkErrorAlert, false)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 1)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 0)
    }

    func testLoadingElementsOnOrderChange() throws {
        let response = try decoder.decode(ReviewsNetworkResponse.self, from: Data(MockReviewResponseResource.value.utf8))
        let networkingClient = MockNetworkingClient(result: .success(response))
        let viewModel = ReviewListsViewModel(networkingClient: networkingClient)

        viewModel.viewAppeared()
        viewModel.ratingOrderSelection = 1
        XCTAssertEqual(viewModel.elements.count, 1)
        XCTAssertEqual(networkingClient.genericExecuteCalledCounter, 2)
        XCTAssertEqual(networkingClient.executeCalledCounter, 0)
        XCTAssertEqual(networkingClient.cancelOnGoingTasksCounter, 1)
    }
}

extension ReviewListsViewModelTests {

    final class MockNetworkingClient: NetworkingClient {

        let result: Result<ReviewsNetworkResponse, Swift.Error>?
        private(set) var genericExecuteCalledCounter = 0
        private(set) var executeCalledCounter = 0
        private(set) var cancelOnGoingTasksCounter = 0

        init(result: Result<ReviewsNetworkResponse, Swift.Error>? = nil) {
            self.result = result
        }

        func execute<Response: Decodable>(request: NetworkRequest, completionHandler: @escaping (Result<Response, Swift.Error>) -> Void) {
            genericExecuteCalledCounter += 1
            guard let result = result as? Result<Response, Swift.Error> else {
                return
            }
            completionHandler(result)
        }

        func execute(request: NetworkRequest, completionHandler: @escaping (Result<Data, Error>) -> Void) {
            executeCalledCounter += 1
        }

        func cancelOnGoingTasks() {
            cancelOnGoingTasksCounter += 1
        }
    }

    struct MockReviewResponseResource {
        static var value: String {
            """
                {
                  "reviews": [
                        \(MockReviewResource.value)
                  ],
                  "totalCount": 0,
                  "averageRating": 0,
                  "pagination": {
                    "limit": 10,
                    "offset": 0
                  }
                }
            """
        }
    }

    struct MockReviewResource {
        static var value: String {
            """
            {
              "id": 11913876,
              "author": {
                "fullName": "Andy",
                "country": "United States",
                "photo": "https://cdn.getyourguide.com/img/customer_img-34544698-2423019138-11.jpg"
              },
              "title": "",
              "message": "Isabelle was a fantastic tour guide and was a wealth of interesting knowledge, and spoke nearly flawless English. The tour started promptly at 1:30 and went about 15 minutes past the 2-hour mark. Learned so many interesting factoids today!",
              "enjoyment": "",
              "isAnonymous": false,
              "rating": 5,
              "created": "2020-02-08T15:20:02+01:00",
              "language": "en"
            }
            """
        }
    }

    enum Error: Swift.Error {
        case mockError
    }
}
