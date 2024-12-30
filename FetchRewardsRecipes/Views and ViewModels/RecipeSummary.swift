//
//  RecipeSummary.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/22/24.
//

import SwiftUI

struct RecipeSummary: View {
    let recipe: Recipe
    let dataService: DataServicing
    
    var url: URL? {
        if let urlString = recipe.photoUrlSmall {
            return URL(string: urlString)
        } else {
            return nil
        }
    }
    var body: some View {
        HStack(spacing: 10) {
            icon
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                Text(recipe.cuisine)
            }
        }
    }
    
    var icon: some View {
        CacheableImage(viewModel: CacheableImageViewModel(dataService: dataService, url: url))
            .frame(width: 60, height: 60)
            .accessibilityHidden(true)
    }
}

#Preview {
    let recipe = Recipe(cuisine: "Testish", name: "test", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "123", sourceUrl: nil, youtubeUrl: nil)
    RecipeSummary(recipe: recipe, dataService: DataService(networkService: NetworkService(downloader: MockHTTPDataDownloader())))
}
