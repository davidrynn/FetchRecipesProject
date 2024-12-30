//
//  DataService.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/22/24.
//

import Foundation

protocol DataServicing {
    
    /// Fetches recipe models from selected endpoint
    /// - Parameter endpointSelection: Selects from 3 endpoints for the project: a list of recipes, empty result, and an error response.
    /// - Returns: An array of `Recipe` models
    func recipes(from endpointSelection: ResponseTypeSelection) async throws -> [Recipe]
    
    /// Fetches image data
    /// - Parameter url: Url for raw image data
    /// - Returns: Raw data for image
    func imageData(from url: URL) async throws -> Data
}

// This implementation of DataServicing uses `actor` to protect the `imageDataCache` property, ensuring
// the cache is serialized. Cache is still vunerable, but handled with task/concurrency
final actor DataService: DataServicing {
    private let networkService: NetworkServicing
    private let baseUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    private let imageDataCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func recipes(from endpointSelection: ResponseTypeSelection) async throws -> [Recipe] {
        let urlString = baseUrlString + endpointSelection.urlString
        guard let url = URL(string: urlString) else { throw FetchRecipeError.invalidURL }
        let recipes: Recipes = try await networkService.fetchDataModel(from: url)
        return recipes.recipes
    }
    
    // Uses tasks for Swift structured concurrency
    func imageData(from url: URL) async throws -> Data {
        // 1. Check cashIf there is cached data already, if the data is ready
        // return data. If the data is in progress:
        // the task download task is returned, preventing repeated downloads.
        if let cached = imageDataCache[url] {
            switch cached {
            case .ready(let data):
                return data
            case .inProgress(let task):
                return try await task.value
            }
        }
        // 2. Create download task.
        let task = Task<Data, Error> {
            let data = try await networkService.fetchData(from: url)
            return data
        }
        // 3. Put task in cache as in progress, so the url will not be used again
        imageDataCache[url] = .inProgress(task)
        do {
            // 4. Starts try await for download task
            let imageData = try await task.value
            // 5. When ready, image data is cached and returned
            imageDataCache[url] = .ready(imageData)
            return imageData
        } catch {
            // 6. If error, nil cache and throw error
            imageDataCache[url] = nil
            throw error
        }
    }
}
