//
//  RecipeModelTests.swift
//  FetchRewardsRecipesTests
//
//  Created by David Rynn on 12/30/24.
//

import XCTest
@testable import FetchRewardsRecipes

final class RecipeModelTests: XCTestCase {
    
    let decoder = JSONDecoder()
    
    func testRecipeModelDecoding_Success() throws {
        let json = testData
        let recipes = try decoder.decode(Recipes.self, from: json)
        
        XCTAssertEqual(recipes.recipes.first?.cuisine, "British")
        XCTAssertEqual(recipes.recipes.first?.name, "Bakewell Tart")
        XCTAssert(recipes.recipes.count == 2)
    }
    
}
