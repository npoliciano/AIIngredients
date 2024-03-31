//
//  AIIngredientsUITests.swift
//  AIIngredientsUITests
//
//  Created by Nicolle on 14/11/23.
//

import XCTest

final class AIIngredientsUITests: XCTestCase {
  private let app = XCUIApplication()

  override func setUpWithError() throws {
    app.launchArguments += ["UITesting"]
    app.launch()

    continueAfterFailure = false
  }

  func test() throws {
    // Onboarding Pages
    let onboardingScreen = app.collectionViews.element
    onboardingScreen.swipeLeft()
    onboardingScreen.swipeLeft()
    onboardingScreen.swipeRight()


    let startButton = app.buttons["Start"]
    startButton.tap()

    // User Name
    let expectedUserName = "Nicolle 🎉"

    let nameField = app.textFields["John Appleseed"]
    nameField.tap()
    nameField.typeText(expectedUserName)

    app.buttons["Next"].tap()

    // Dietary Preferences
    let glutenToggle = app.switches["glutenFreeToggle"]
    let sugarToggle = app.switches["sugarFreeToggle"]
    let vegetarianToggle = app.switches["vegetarianToggle"]
    let lactoToggle = app.switches["lactoseFreeToggle"]
    let veganToggle = app.switches["veganToggle"]

    XCTAssertEqual(glutenToggle.value as? String, "0")
    XCTAssertEqual(sugarToggle.value as? String, "0")
    XCTAssertEqual(vegetarianToggle.value as? String, "0")
    XCTAssertEqual(lactoToggle.value as? String, "0")
    XCTAssertEqual(veganToggle.value as? String, "0")

    app.buttons["Next"].tap()

    // Home
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["User"].tap()

    // User
    XCTAssertTrue(app.navigationBars[expectedUserName].exists)
    tabBar.buttons["Home"].tap()

    // Home
    app.buttons["Start Adding"].tap()

    // Build your meal
    let mealField = app.textFields["E.g. greek salad, fried rice..."]
    mealField.tap()
    mealField.typeText("Chicken Pie")

    let portionField = app.textFields["portionField"]
    portionField.tap()
    portionField.typeText("200")

    let measurementPicker = app.buttons["measurementPicker"]
    measurementPicker.tap()
    app.buttons["ml"].tap()

    app.toolbars.buttons["GoUp"].tap()
    app.toolbars.buttons["GoDown"].tap()

    app.toolbars.buttons["Done"].tap()

    app.buttons["Increment"].tap()
    app.buttons["Increment"].tap()
    app.buttons["Decrement"].tap()
    app.buttons["Increment"].tap()

    app.buttons["Back"].tap()
    app.buttons["Add"].tap()
  }
}
