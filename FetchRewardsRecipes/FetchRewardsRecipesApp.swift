//
//  FetchRewardsRecipesApp.swift
//  FetchRewardsRecipes
//
//  Created by David Rynn on 12/29/24.
//

import SwiftUI

@main
struct FetchRewardsRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesView(viewModel: RecipeViewModel(dataService: DataService()))
        }
    }
}
