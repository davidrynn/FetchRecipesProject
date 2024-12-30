//
//  HTTPDataDownloader.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/25/24.
//

/*
 Taken from:
 https://developer.apple.com/tutorials/app-dev-training/building-a-network-test-client
 Abstract:
 A protocol describing an HTTP Data Downloader.
 */

import Foundation

let validStatus = 200...299
/// A protocol describing an HTTP Data Downloader.
protocol HTTPDataDownloader {
    
    /// Basic http data download call.
    /// - Parameter from: URL object for making call
    /// - Returns: Data of type `Data`
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw FetchRecipeError.invalidResponse
        }
        return data
    }
}

/// Network downloader used for unit tests and previews
final class MockHTTPDataDownloader: HTTPDataDownloader {
    // data property can be changed to suit needs
    var shouldFail: Bool = false
    func httpData(from url: URL) async throws -> Data {
        guard let responseTypeSelection = ResponseTypeSelection(urlString: url.absoluteString) else {
            throw FetchRecipeError.invalidURL
        }
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        if shouldFail {
            throw FetchRecipeError.networkError
        }
        return responseTypeSelection.data
    }
}
