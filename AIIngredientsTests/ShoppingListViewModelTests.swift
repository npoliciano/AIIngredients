//
//  ShoppingListViewModelTests.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 23/11/23.
//

import XCTest

@testable import AIIngredients

final class ShoppingListViewModelTests: XCTestCase {
  var defaults = UserDefaults.testDefaults()

  override func setUp() {
    super.setUp()

    defaults = UserDefaults.testDefaults()
  }

  func testInitWithValidData() {
    defaults.userName = "some user name"
    let existingList = Meal.fixture()
    defaults.shoppingLists = [existingList]

    let sut = ShoppingListViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.userName, "some user name")
    XCTAssertEqual(sut.shoppingLists, [existingList])
  }

  func testReactsToNotifications() {
    let sut = ShoppingListViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.shoppingLists, [])

    let newMeal1 = Meal.fixture()
    simulateUpdateShoppingList(newMeal1)

    XCTAssertEqual(sut.shoppingLists, [newMeal1])

    let newMeal2 = Meal.fixture()

    simulateUpdateShoppingList(newMeal2)

    XCTAssertEqual(sut.shoppingLists, [newMeal2, newMeal1])
  }

  private func simulateUpdateShoppingList(_ meal: Meal) {
    defaults.shoppingLists.append(meal)
    NotificationCenter.default.post(
      name: .onUpdateShoppingList,
      object: nil
    )
  }
}
