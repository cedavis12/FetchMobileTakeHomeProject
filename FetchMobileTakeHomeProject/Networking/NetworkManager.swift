//
//  NetworkManager.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

import Foundation

public protocol NetworkManagerProtocol: AnyObject {
    func fetchRecipes() async throws -> [Recipe]
}

class NetworkManager: NetworkManagerProtocol {
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

        guard let url = URL(string: urlString) else {
            throw CustomError.badRequest
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw CustomError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(RecipeResponse.self, from: data)
            return response.recipes
        }
        catch {
            throw CustomError.invalidData
        }
    }
}
