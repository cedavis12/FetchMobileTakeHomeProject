//
//  ContentView.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeListView: View {
    @StateObject
    var viewModel: RecipeLoaderViewModel

    private func fetchRecipes() {
        Task {
            await viewModel.fetchRecipes()
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .initial, .empty:
                    EmptyView {
                        fetchRecipes()
                    }
                case .error(let error):
                    ErrorView(errorText: error) {
                        fetchRecipes()
                    }
                case .loading:
                    ProgressView()
                case .loaded(let recipes):
                    List(recipes, id: \.uuid) { recipe in
                        RecipeListItem(recipe: recipe)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 16, weight: .regular))
                    .onTapGesture {
                        fetchRecipes()
                    }
            }
            .navigationBarHidden(viewModel.navigationBarIsHidden)
            .onAppear {
                fetchRecipes()
            }
        }
    }
}

struct EmptyView: View {
    var action: () -> Void
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: "hand.wave.fill")
                .resizable()
                .symbolRenderingMode(.monochrome)
                .foregroundColor(Color.yellow)
                .font(.system(size: 16, weight: .regular))
                .frame(width: 50, height: 50)
            Text("Nothing to see here.")
                .font(.title)
                .multilineTextAlignment(.center)
            Button("Try Again", action: action)
                .buttonStyle(RetryButtonStyle())
        }
    }
}

struct ErrorView: View {
    var errorText: String
    var action: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .symbolRenderingMode(.monochrome)
                .foregroundColor(Color.red)
                .font(.system(size: 16, weight: .regular))
                .frame(width: 50, height: 50)
            Text("Something went wrong")
                .font(.title)
                .multilineTextAlignment(.center)
            Text(errorText)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            Button("Try Again", action: action)
                .buttonStyle(RetryButtonStyle())
        }
    }
}

struct RecipeListItem: View {
    var recipe: Recipe

    var body: some View {
        HStack {
            WebImage(url: URL(string: recipe.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .font(.system(size: 16, weight: .regular))

            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 50, height: 50, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
            }
        }
    }
}

struct RetryButtonStyle: ButtonStyle {
    public func makeBody(configuration: RetryButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }

    struct MyButton: View {
        let configuration: RetryButtonStyle.Configuration
        var body: some View {

            return configuration.label
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(RoundedRectangle(cornerRadius: 5).fill(.black))
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .opacity(configuration.isPressed ? 0.5 : 1)
        }
    }
}

#Preview {
    RecipeListView(viewModel: .init(networkManager: NetworkManager()))
}
