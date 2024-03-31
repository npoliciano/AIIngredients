//
//  UserPreferencesViewModelTests.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import XCTest

@testable import AIIngredients

final class UserPreferencesViewModelTests: XCTestCase {
  let defaults = UserDefaults.testDefaults()

  func testInitsWithValidData() {
    let existingPreferences = DietaryPreferences(
      glutenFree: false,
      lactoseFree: true,
      sugarFree: true,
      vegan: false,
      vegetarian: false
    )
    defaults.dietaryPreferences = existingPreferences
    let sut = UserPreferencesViewModel(userDefaults: defaults)

    XCTAssertEqual(defaults.dietaryPreferences, existingPreferences)
    XCTAssertEqual(
      sut.preferences,
      DietaryPreferences(
        glutenFree: false,
        lactoseFree: false,
        sugarFree: false,
        vegan: false,
        vegetarian: false
      )
    )
  }
}
