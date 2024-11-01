//
//  RecipeViewModelTests.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 11/1/24.
//

import Mocker
import XCTest
@testable import FetchMobileTakeHomeProject

@MainActor
final class RecipeViewModelTests: XCTestCase {
    func testGetRecipesReturnsCorrectStates() async {
        let viewModelUnderTest = RecipeLoaderViewModel(networkManager: MockNetworkManager())

        let expectedViewStates: [RecipeLoaderViewModel.ViewState] = [
            .initial,
            .loading,
            .loaded([MockedData.mockRecipe]),
        ]

        var viewStates: [RecipeLoaderViewModel.ViewState] = []

        let expectation = XCTestExpectation(description: "wait until final state")

        let subscription = viewModelUnderTest.$state.sink { state in
            viewStates.append(state)
            if viewStates.count == expectedViewStates.count {
                expectation.fulfill()
            }
        }

        await viewModelUnderTest.fetchRecipes()

        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(viewStates, expectedViewStates)
        subscription.cancel()
    }

    func testEmptyGetRecipesReturnsCorrectStates() async {
        let viewModelUnderTest = RecipeLoaderViewModel(networkManager: MockEmptyRecipeNetworkManager())

        let expectedViewStates: [RecipeLoaderViewModel.ViewState] = [
            .initial,
            .loading,
            .empty,
        ]

        var viewStates: [RecipeLoaderViewModel.ViewState] = []

        let expectation = XCTestExpectation(description: "wait until final state")

        let subscription = viewModelUnderTest.$state.sink { state in
            viewStates.append(state)
            if viewStates.count == expectedViewStates.count {
                expectation.fulfill()
            }
        }

        await viewModelUnderTest.fetchRecipes()

        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(viewStates, expectedViewStates)
        subscription.cancel()
    }

    func testMalformedGetRecipesReturnsCorrectStates() async {
        let viewModelUnderTest = RecipeLoaderViewModel(networkManager: MockMalformedRecipeNetworkManager())

        let expectedViewStates: [RecipeLoaderViewModel.ViewState] = [
            .initial,
            .loading,
            .error(MockedData.mockError),
        ]

        var viewStates: [RecipeLoaderViewModel.ViewState] = []

        let expectation = XCTestExpectation(description: "wait until final state")

        let subscription = viewModelUnderTest.$state.sink { state in
            viewStates.append(state)
            if viewStates.count == expectedViewStates.count {
                expectation.fulfill()
            }
        }

        await viewModelUnderTest.fetchRecipes()

        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(viewStates, expectedViewStates)
        subscription.cancel()
    }
}
