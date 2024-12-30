//
//  NetworkService.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/25/24.
//

import Foundation

protocol NetworkServicing {
    /// Generic fetch function for data to model
    /// - Parameter url: Url for JSON data
    /// - Returns: Models of Generic T Decodable type.
    func fetchDataModel<T: Decodable>(from url: URL) async throws -> T
    
    /// Simple wrapper around downloader
    /// - Parameter url: Url for JSON data
    /// - Returns: Raw data, not decoded.
    func fetchData(from url: URL) async throws -> Data
}

final class NetworkService: NetworkServicing {
    // MARK: - Properties
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        return aDecoder
    }()
    private let downloader: any HTTPDataDownloader
    
    // MARK: - Initializer
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    // MARK: - Functions
    func fetchDataModel<T: Decodable>(from url: URL) async throws -> T {
        do {
            let data = try await downloader.httpData(from: url)
            let responseData = try decoder.decode(T.self, from: data)
            return responseData
        } catch let error {
            if error is DecodingError {
                throw FetchRecipeError.invalidData
            } else if error is URLError {
                throw FetchRecipeError.networkError
            }
            throw error
        }
    }
    
    func fetchData(from url: URL) async throws -> Data {
        return try await downloader.httpData(from: url)
    }
    
}
