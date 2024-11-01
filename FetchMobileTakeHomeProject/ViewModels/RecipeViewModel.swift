//
//  RecipeViewModel.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

import Foundation
import UIKit

class RecipeLoaderViewModel: ObservableObject {
    private let networkManager: NetworkManagerProtocol

    enum ViewState: Equatable {
        case initial
        case empty
        case error(String)
        case loading
        case loaded([Recipe])
    }

    @Published
    private(set) var state: ViewState = .initial

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    @MainActor
    func fetchRecipes() async {
        state = .loading

        do {
            let recipes = try await networkManager.fetchRecipes()
            if recipes.isEmpty {
                state = .empty
            }
            else {
                state = .loaded(recipes)
            }
        }
        catch let error as CustomError {
            state = .error(error.localizedDescription)
        }
        catch {
            state = .error(error.localizedDescription)
        }
    }

    var navigationBarIsHidden: Bool {
        switch state {
        case .loaded:
            return false
        default:
            return true
        }
    }
}
