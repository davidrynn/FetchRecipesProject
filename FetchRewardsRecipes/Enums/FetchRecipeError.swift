//
//  FetchRecipeError.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/22/24.
//

enum FetchRecipeError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        case .networkError:
            return "Network error"
        }
    }
}
