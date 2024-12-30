//
//  RecipesViewModelTest.swift
//  FetchRewardsRecipesTests
//
//  Created by David Rynn on 12/30/24.
//

import XCTest
@testable import FetchRewardsRecipes

final class RecipesViewModelTest: XCTestCase {
    
    var sut: RecipesViewModel!
    let decoder = JSONDecoder()
    
    override func setUp() {
        let downloader = MockHTTPDataDownloader()
        let service = NetworkService(downloader: downloader)
        let dataService = DataService(networkService: service)
        sut = RecipesViewModel(dataService: dataService)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testLoadRecipes() async throws {
        // Given
        let expectationContainer = try decoder.decode(Recipes.self, from: testData)
        let expectated = expectationContainer.recipes
        let expectation = XCTestExpectation(description: "Load recipes asynchronously.")
        
        // When
        await sut.loadRecipes()
        XCTAssertEqual(sut.recipes, expectated)
        
        // Then
        expectation.fulfill()
        
    }
    
}
