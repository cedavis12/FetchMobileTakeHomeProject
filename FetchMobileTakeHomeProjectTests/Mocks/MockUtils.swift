//
//  MockData.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

import Foundation
import FetchMobileTakeHomeProject

public final class MockedData {
    public static let successfulJSON: URL = Bundle.module.url(forResource: "recipes", withExtension: "json")!
    public static let emptyJSON: URL = Bundle.module.url(forResource: "emptyRecipes", withExtension: "json")!
    public static let malformedJSON: URL = Bundle.module.url(forResource: "malformedRecipes", withExtension: "json")!
    public static let mockRecipe: Recipe = .init(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )
    public static let mockError: String = "The data couldn’t be read because it is missing."
}

extension Bundle {
#if !SWIFT_PACKAGE
    static let module = Bundle(for: MockedData.self)
#endif
}

internal extension URL {
    /// Returns a `Data` representation of the current `URL`. Force unwrapping as it's only used for tests.
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
