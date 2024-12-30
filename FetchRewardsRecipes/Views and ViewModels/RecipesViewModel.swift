//
//  RecipeViewModel.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/25/24.
//

import Foundation

final class RecipesViewModel: ObservableObject {
    // MARK: Public properties
    let dataService: DataServicing
    
    // MARK: Property wrappers
    @Published var loadingState: LoadingState = .loading
    @Published var recipes: [Recipe]
    @Published var errorMessage: String?
    @Published var selectedEndpoint: ResponseTypeSelection = .allRecipes
    var title: String {
        return switch loadingState {
        case .loading:
            " " // Need space here - otherwise Nav title will appear to jump because it's empty when loading.
        case .loaded:
            "Recipes"
        case .error:
            "Error"
        case .empty:
            "No recipes"
        }
    }
    
    // MARK: Initialization
    init(dataService: DataServicing) {
        self.dataService = dataService
        self.recipes = []
        Task {
            await loadRecipes()
        }
    }
    
    @MainActor
    func loadRecipes() async {
        loadingState = .loading
        do {
            self.recipes = try await dataService.recipes(from: selectedEndpoint)
            loadingState = self.recipes.isEmpty ? .empty : .loaded
        } catch {
            loadingState = .error
            if let error = error as? FetchRecipeError {
                errorMessage = error.message
            }
        }
    }
}
