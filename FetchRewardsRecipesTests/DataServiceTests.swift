//
//  DataServiceTests.swift
//  FetchRecipesTests
//
//  Created by David Rynn on 12/26/24.
//

import XCTest
@testable import FetchRewardsRecipes

final class DataServiceTests: XCTestCase {
    var sut: DataService!
    var networkService: NetworkService!
    let decoder: JSONDecoder = JSONDecoder()
    var downloader: MockHTTPDataDownloader!
    
    override func setUp() {
        downloader = MockHTTPDataDownloader()
        networkService = NetworkService(downloader: downloader)
        sut = DataService(networkService: networkService)
    }
    
    override func tearDown() {
        sut = nil
        networkService = nil
        downloader = nil
    }
    
    func testRecipesFromURL_Success() async throws {
        // Given
        let expectationContainer = try decoder.decode(Recipes.self, from: testData)
        let expectation = expectationContainer.recipes
        
        // When
        let recipes = try await sut.recipes(from: .allRecipes)
        
        // Then
        XCTAssertEqual(recipes, expectation)
    }
    
    func testRecipesFromURL_Error() async {
        // Given
        let expectation = FetchRecipeError.networkError
        downloader.shouldFail = true
        // When
        do {
            let _ = try await sut.recipes(from: .malformed)
        } catch let error {
            // Then
            guard let error = error as? FetchRecipeError else {
                XCTFail("Invalid Error")
                return
            }
            XCTAssertEqual(error, expectation)
            return
        }
        XCTFail("Error not thrown")
    }
    
    func testRecipesFromURL_Success_Empty() async throws {
        // Given
        // networkService.responseTypeSelection = .empty
        let expectation = [Recipe]()
        
        // When
        let recipes = try await sut.recipes(from: .empty)
        
        // Then
        XCTAssertEqual(recipes, expectation)
    }
    
    func testDataFromURL_Success() async throws {
        // Given
        let expectation = testData
        
        // When
        let data = try await sut.imageData(from: URL(string: allRecipesFullUrlString)!)
        
        // Then
        XCTAssertEqual(data, expectation)
    }
    
    func testDataFromURL_Error() async throws {
        // Given
        downloader.shouldFail = true
        let expectation = FetchRecipeError.invalidURL
        // When
        do {
            let _ = try await sut.imageData(from: URL(string: ResponseTypeSelection.allRecipes.urlString)!)
        } catch let error {
            // Then
            guard let error = error as? FetchRecipeError else {
                XCTFail("Expected error to be FetchRecipeError")
                return
            }
            XCTAssertEqual(error, expectation)
            return
        }
        
        XCTFail( "Expected error not thrown")
    }
    
}
