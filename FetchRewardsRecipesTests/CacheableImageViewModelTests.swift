//
//  CacheableImageViewModelTests.swift
//  FetchRewardsRecipesTests
//
//  Created by David Rynn on 12/30/24.
//

import XCTest
@testable import FetchRewardsRecipes

final class CacheableImageViewModelTests: XCTestCase {
    var sut: CacheableImageViewModel!
    let urlString = "https://some.url/small.jpg"
    
    override func setUpWithError() throws {
        let network = NetworkService(downloader: MockHTTPDataDownloader())
        let dataService = DataService(networkService: network)
        let url = URL(string: urlString)
        sut = CacheableImageViewModel(dataService: dataService, url: url)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadImage() async throws {
        // Given
        XCTAssert(sut.errorMessage == nil)
        let expectation = XCTestExpectation(description: "Load image asynchronously.")
        
        // When
        await sut.loadImage() // In testing will not load an image without error.
        XCTAssert(sut.errorMessage != nil)
        
        // Then
        expectation.fulfill()
        
    }
}
