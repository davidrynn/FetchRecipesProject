//
//  Recipe.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/22/24.
//

import Foundation

struct Recipes: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    var id: String {
        return self.uuid
    }
    
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
    
    init(cuisine: String, name: String, photoUrlLarge: String?, photoUrlSmall: String?, uuid: String, sourceUrl: String?, youtubeUrl: String?) {
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.uuid = uuid
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.uuid == rhs.uuid &&
        lhs.name == rhs.name &&
        lhs.cuisine == rhs.cuisine &&
        lhs.sourceUrl == rhs.sourceUrl &&
        lhs.youtubeUrl == rhs.youtubeUrl &&
        lhs.photoUrlLarge == rhs.photoUrlLarge &&
        lhs.photoUrlSmall == rhs.photoUrlSmall
    }
}
