//
//  UserDetailViewModelTests.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import XCTest

@testable import AIIngredients

final class UserDetailViewModelTests: XCTestCase {
  let defaults = UserDefaults.testDefaults()

  func testInitsWithNilDietaryPreferences() {
    defaults.userName = "some name"
    defaults.dietaryPreferences = nil

    let sut = UserDetailViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.userName, "some name")
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

  func testInitsWithSomeDietaryPreferences() {
    defaults.userName = "some name"
    let previousPreference = DietaryPreferences(
      glutenFree: true,
      lactoseFree: true,
      sugarFree: false,
      vegan: true,
      vegetarian: false
    )
    defaults.dietaryPreferences = previousPreference

    let sut = UserDetailViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.userName, "some name")
    XCTAssertEqual(sut.preferences, previousPreference)
  }

  func testUpdatesDietaryPreferencesDefaults() {
    let previousPreference = DietaryPreferences(
      glutenFree: true,
      lactoseFree: true,
      sugarFree: false,
      vegan: true,
      vegetarian: false
    )
    defaults.dietaryPreferences = previousPreference

    let sut = UserDetailViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.preferences, previousPreference)

    sut.preferences.glutenFree = false
    sut.preferences.lactoseFree = false
    sut.preferences.sugarFree = true
    sut.preferences.vegan = true
    sut.preferences.vegetarian = false

    XCTAssertEqual(
      defaults.dietaryPreferences,
      DietaryPreferences(
        glutenFree: false,
        lactoseFree: false,
        sugarFree: true,
        vegan: true,
        vegetarian: false
      )
    )
  }
}
