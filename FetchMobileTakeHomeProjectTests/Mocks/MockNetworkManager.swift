//
//  MockNetworkManager.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 11/1/24.
//

import Foundation
@testable import FetchMobileTakeHomeProject

final class MockNetworkManager: NetworkManagerProtocol {
    func fetchRecipes() async throws -> [FetchMobileTakeHomeProject.Recipe] {
        do {
            let data = try Data(contentsOf: MockedData.successfulJSON)
            let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return response.recipes
        }
        catch {
            throw error
        }
    }
}

final class MockEmptyRecipeNetworkManager: NetworkManagerProtocol {
    func fetchRecipes() async throws -> [FetchMobileTakeHomeProject.Recipe] {
        do {
            let data = try Data(contentsOf: MockedData.emptyJSON)
            let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return response.recipes
        }
        catch {
            throw error
        }
    }
}

final class MockMalformedRecipeNetworkManager: NetworkManagerProtocol {
    func fetchRecipes() async throws -> [FetchMobileTakeHomeProject.Recipe] {
        do {
            let data = try Data(contentsOf: MockedData.malformedJSON)
            let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return response.recipes
        }
        catch {
            throw error
        }
    }
}
