//
//  CapstoneTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 14/11/23.
//

import XCTest

@testable import Capstone

final class BuildYourMealViewModelTests: XCTestCase {
    typealias AlertError = BuildYourMealViewModel.AlertError

    func testInitWithDefaultValues() {
        // Arrange & Act
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        let preSelectedPortionType = Measurements.g

        // Assert
        XCTAssertEqual(sut.mealName, "")
        XCTAssertEqual(sut.portion, "")
        XCTAssertEqual(sut.selectedPortionType, preSelectedPortionType)
        XCTAssertEqual(sut.quantity, 1)
        XCTAssertEqual(sut.quantityRange, 1 ... Int.max)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.alertError)
        XCTAssertNil(sut.meal)

        XCTAssertFalse(generator.generateCalled)

        XCTAssertEqual(sut.measurements, [
            preSelectedPortionType,
            .kg,
            .pieces,
            .units,
            .ml,
            .litres,
            .unespecified
        ])
    }

    func testShowErrorWhenThereIsNoMealNameAndPortion() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = ""
        sut.portion = ""

        // Act
        sut.onTap()

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(generator.generateCalled)
        XCTAssertEqual(sut.alertError, AlertError(
            title: "Required Fields Missing",
            message: "Please enter the \"Meal\" and \"Portion size\" details. Both fields are required to proceed."
        ))
    }

    func testShowErrorWhenThereIsNoMealName() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = ""
        sut.portion = "Some portion"

        // Act
        sut.onTap()

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(generator.generateCalled)
        XCTAssertEqual(sut.alertError, AlertError(
            title: "Required Field Missing",
            message: "Please enter the \"Meal\" details. This field is required to proceed."
        ))
    }

    func testShowErrorWhenThereIsNoPortion() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = "Some meal"
        sut.portion = ""

        // Act
        sut.onTap()

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(generator.generateCalled)
        XCTAssertEqual(sut.alertError, AlertError(
            title: "Required Field Missing",
            message: "Please enter the \"Portion size\" details. This field is required to proceed."
        ))
    }

    func testShowLoadingWhenTheFormIsValid() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = "Some meal"
        sut.portion = "Some portion"
        sut.quantity = 3
        sut.selectedPortionType = Measurements.kg

        // Act
        sut.onTap()

        // Assert
        let expectedInput = ListGeneratorInput(
            meal: "Some meal",
            portion: "Some portion",
            measurement: .kg,
            quantity: 3
        )
        XCTAssertEqual(generator.receivedInput, expectedInput)
        XCTAssertTrue(generator.generateCalled)
        XCTAssertTrue(sut.isLoading)
        XCTAssertNil(sut.alertError)
    }

    func testShowsGenericErrorWhenFailToGenerate() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = "Some meal"
        sut.portion = "Some portion"

        // Act
        sut.onTap()

        // Assert
        XCTAssertTrue(sut.isLoading)

        // Act: Simulate async list generation completion with failure
        generator.completion?(.failure(ErrorDummy()))

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.alertError, AlertError(
            title: "Sorry!",
            message: "Something went wrong. Please, try again later."
        ))
    }

    func testShowsNetworkError() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = "Some meal"
        sut.portion = "Some portion"
        let specificErrorMessage = AppError.network

        // Act
        sut.onTap()

        // Assert
        XCTAssertTrue(sut.isLoading)

        // Act: Simulate async list generation completion with failure
        generator.completion?(.failure(specificErrorMessage))

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.alertError, AlertError(
            title: "Sorry!",
            message: "It seems like we're having trouble connecting. Please check your internet connection and try again"
        ))
    }

    func testShowsServerError() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = "Some meal"
        sut.portion = "Some portion"
        let specificErrorMessage = AppError.server

        // Act
        sut.onTap()

        // Assert
        XCTAssertTrue(sut.isLoading)

        // Act: Simulate async list generation completion with failure
        generator.completion?(.failure(specificErrorMessage))

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.alertError, AlertError(
            title: "Sorry!",
            message: "We encountered an issue generating the ingredients list. Please check the details of your request and try again"
        ))
    }

    func testReceiveNewMealWhenGeneratesSuccessfully() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.mealName = "Some meal"
        sut.portion = "Some portion"
        let expectedMeal = Meal.fixture(name: "Generated Meal", ingredients: [])


        // Act
        sut.onTap()

        // Assert
        XCTAssertTrue(sut.isLoading)

        // Act: Simulate async list generation completion with success
        generator.completion?(.success(expectedMeal))

        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.meal, expectedMeal)
    }
}

struct ErrorDummy: Error { }

final class ListGeneratorSpy: ListGenerator {
    var generateCalled = false
    var receivedInput: ListGeneratorInput?

    var completion: ((Result<Meal, Error>) -> Void)?

    func generate(
        from input: ListGeneratorInput,
        completion: @escaping (Result<Meal, Error>) -> Void
    ) {
        generateCalled = true
        receivedInput = input
        self.completion = completion
    }
}
