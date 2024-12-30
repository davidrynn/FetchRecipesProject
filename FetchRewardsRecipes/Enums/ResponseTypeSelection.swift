//
//  ResponseTypeSelection.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/22/24.
//
import Foundation

/// Helper enum for changing endpoints based on desired outcome
/// In a production app urls would NOT be exposed like this.
enum ResponseTypeSelection: String, CaseIterable, Identifiable {
    case allRecipes = "All Recipes"
    case empty = "Empty"
    case malformed = "Malformed"
    
    /// Init used for mock downloader
    /// - Parameter urlString: One of three urls
    init?(urlString: String) {
        switch urlString {
        case allRecipesFullUrlString:
            self = .allRecipes
        case emptyFullUrlString:
            self = .empty
        case malformedFullUrlString:
            self = .malformed
        default:
            return nil
        }
    }
    
    var urlString: String {
        switch self {
        case .allRecipes: return "recipes.json"
        case .empty: return "recipes-empty.json"
        case .malformed: return "recipes-malformed.json"
        }
    }
    
    var id: String {
        return self.rawValue
    }
    
    // For downloader Mock
    var data: Data {
        switch self {
        case .allRecipes: return testData
        case .empty: return emptyData
        case .malformed: return malformedData
        }
    }
    
}
