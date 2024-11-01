//
//  FetchMobileTakeHomeProjectApp.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

import SwiftUI

@main
struct FetchMobileTakeHomeProjectApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = RecipeLoaderViewModel(networkManager: NetworkManager())
            RecipeListView(viewModel: viewModel)
        }
    }
}
