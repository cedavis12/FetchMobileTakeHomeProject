//
//  FetchMobileTakeHomeProjectTests.swift
//  FetchMobileTakeHomeProjectTests
//
//  Created by Courtney Davis on 10/31/24.
//

import Mocker
import XCTest
@testable import FetchMobileTakeHomeProject

final class NetworkManagerTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Mocker.mode = .optout
    }

    override func tearDown() {
        Mocker.removeAll()
        Mocker.mode = .optout
        super.tearDown()
    }

    func testFetchingRecipes() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = URLSession(configuration: configuration)

        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let mockedData = MockedData.mockRecipe
        let requestExpectation = expectation(description: "Request should finish")

        let mock = Mock(url: url, contentType: .json, statusCode: 200, data: [
            .get: MockedData.successfulJSON.data
        ])

        mock.register()

        sessionManager.dataTask(with: url) { (data, response, error) in
            defer { requestExpectation.fulfill() }
            do {
                if let error = error {
                    XCTFail(error.localizedDescription)
                }

                let response = try JSONDecoder().decode(RecipeResponse.self, from: data!)
                XCTAssertEqual(response.recipes[0], mockedData)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }.resume()

        wait(for: [requestExpectation], timeout: 10.0)
    }
}
