//
//  NetworkServiceTests.swift
//  FetchRecipesTests
//
//  Created by David Rynn on 12/28/24.
//

import XCTest
@testable import FetchRewardsRecipes

final class NetworkServiceTests: XCTestCase {
    
    var sut: NetworkService!
    var downloader: MockHTTPDataDownloader!
    let decoder: JSONDecoder = JSONDecoder()

    override func setUp() {
        downloader = MockHTTPDataDownloader()
        sut = NetworkService(downloader: downloader)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testFetchDataModels_Success() async throws {
        // Given
        let expectationContainer = try decoder.decode(Recipes.self, from: testData)
        let expectation = expectationContainer.recipes
  
        // When
        let recipesContainer: Recipes = try await sut.fetchDataModel(from: URL(string: allRecipesFullUrlString)!)
        let recipes: [Recipe] = recipesContainer.recipes
        
        // Then
        XCTAssertEqual(recipes, expectation)
        
    }
    
    func testFetchDataModels_MalformedData() async {
        // Given
        let expectation = FetchRecipeError.invalidData
        let service = NetworkService(downloader: downloader)
        do {
            // When
            let _: Recipes = try await service.fetchDataModel(from: URL(string: malformedFullUrlString)!)
        } catch let error {
            guard let error = error as? FetchRecipeError else {
                XCTFail("Expected FetchRecipeError")
                return
            }
            // Then
            XCTAssertEqual(error, expectation)
            return
        }
        XCTFail("Expected throw but did not throw")
    }
    
    func testFetchDataModels_Success_Empty() async throws {
        // Given
        let expectationContainer = try decoder.decode(Recipes.self, from: emptyData)
        let expectation = expectationContainer.recipes
  
        // When
        let recipesContainer: Recipes = try await sut.fetchDataModel(from: URL(string: emptyFullUrlString)!)
        let recipes: [Recipe] = recipesContainer.recipes
        
        // Then
        XCTAssertEqual(recipes, expectation)
        
    }
    
    func testFetchData_Success() async throws {
        // Given
        let expectation = testData
  
        // When
        let data = try await sut.fetchData(from: URL(string: allRecipesFullUrlString)!)
        
        // Then
        XCTAssertEqual(data, expectation)
        
    }
    
    func testFetchData_Success_empty() async throws {
        // Given
        let expectation = emptyData
        // When
        let data = try await sut.fetchData(from: URL(string: emptyFullUrlString)!)
        
        // Then
        XCTAssertEqual(data, expectation)
    }
    
    func testFetchData_Malformed() async throws {
        // Given
        let expectation = malformedData

        // When
        let data = try await sut.fetchData(from: URL(string: malformedFullUrlString)!)
        
        // Then
        XCTAssertEqual(data, expectation)
    }

}
