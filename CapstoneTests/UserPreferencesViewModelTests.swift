//
//  UserPreferencesViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import XCTest

@testable import Capstone

final class UserPreferencesViewModelTests: XCTestCase {
  var defaults: UserDefaults!

  override func setUp() {
    super.setUp()

    defaults = UserDefaults(suiteName: #file)
    defaults.removePersistentDomain(forName: #file)
  }

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
