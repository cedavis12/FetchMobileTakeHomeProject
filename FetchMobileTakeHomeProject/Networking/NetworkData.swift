//
//  NetworkData.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

public struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

public struct Recipe: Codable, Equatable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String
    let sourceUrl: String?
    let youtubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }

    public init(cuisine: String, name: String, photoUrlLarge: String?, photoUrlSmall: String?, uuid: String, sourceUrl: String?, youtubeUrl: String?) {
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.uuid = uuid
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
}

extension Recipe {
    var imageURL: String {
        if let largePhoto = photoUrlLarge {
            return largePhoto
        }
        else if let smallPhoto = photoUrlSmall {
            return smallPhoto
        }
        else {
            return ""
        }
    }
}
