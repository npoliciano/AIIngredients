//
//  ShoppingListReviewViewModelTests.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 23/11/23.
//

import XCTest

@testable import AIIngredients

final class ShoppingListReviewViewModelTests: XCTestCase {
  let defaults = UserDefaults.testDefaults()

  func testInitDoesNotSaveTheMeal() {
    defaults.shoppingLists = []
    let ingredient = Ingredient.fixture()
    let sut = ShoppingListReviewViewModel(
      meal: Meal.fixture(name: "some name", ingredients: [ingredient]),
      userDefaults: defaults
    )

    XCTAssertTrue(defaults.shoppingLists.isEmpty)
    XCTAssertEqual(sut.name, "some name")
    XCTAssertEqual(sut.ingredients, [ingredient])
  }

  func testAppendNewMealOnConfirm() {
    let existingMeal = Meal.fixture()
    defaults.shoppingLists = [existingMeal]
    let newMeal = Meal.fixture()

    let sut = ShoppingListReviewViewModel(
      meal: newMeal,
      userDefaults: defaults
    )
    expectation(
      forNotification: .onUpdateShoppingList,
      object: nil
    ) { _ in true }

    sut.onConfirm()

    waitForExpectations(timeout: 1, handler: nil)

    XCTAssertEqual(defaults.shoppingLists, [existingMeal, newMeal])
  }
}
