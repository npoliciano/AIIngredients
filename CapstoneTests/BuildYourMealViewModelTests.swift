//
//  CapstoneTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 14/11/23.
//

import XCTest

@testable import Capstone

final class BuildYourMealViewModelTests: XCTestCase {
    typealias Error = BuildYourMealViewModel.Error
    
    func testInitWithDefaultValues() {
        // Arrange & Act
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        let preSelectedPortionType = Measurements.g
        
        // Assert
        XCTAssertEqual(sut.meal, "")
        XCTAssertEqual(sut.portion, "")
        XCTAssertEqual(sut.selectedPortionType, preSelectedPortionType)
        XCTAssertEqual(sut.quantity, 1)
        XCTAssertEqual(sut.quantityRange, 1 ... Int.max)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.error)
        
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
    
    func testShowErrorWhenThereIsNoMealAndPortion() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.meal = ""
        sut.portion = ""
        
        // Act
        sut.onTap()
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(generator.generateCalled)
        XCTAssertEqual(sut.error, Error(
            title: "Required Fields Missing",
            message: "Please enter the \"Meal\" and \"Portion size\" details. Both fields are required to proceed."
        ))
    }
    
    func testShowErrorWhenThereIsNoMeal() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.meal = ""
        sut.portion = "Some portion"
        
        // Act
        sut.onTap()
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(generator.generateCalled)
        XCTAssertEqual(sut.error, Error(
            title: "Required Field Missing",
            message: "Please enter the \"Meal\" details. This field is required to proceed."
        ))
    }
    
    func testShowErrorWhenThereIsNoPortion() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.meal = "Some meal"
        sut.portion = ""
        
        // Act
        sut.onTap()
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(generator.generateCalled)
        XCTAssertEqual(sut.error, Error(
            title: "Required Field Missing",
            message: "Please enter the \"Portion size\" details. This field is required to proceed."
        ))
    }
    
    func testShowLoadingWhenTheFormIsValid() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.meal = "Some meal"
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
        XCTAssertNil(sut.error)
    }
    
    func testShowErrorWhenFailToGenerate() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.meal = "Some meal"
        sut.portion = "Some portion"
        
        // Act
        sut.onTap()
        
        // Assert
        XCTAssertTrue(sut.isLoading)
        
        // Act: Simulate async list generation completion with failure
        generator.completion?(.failure(ErrorDummy()))
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.error, Error(
            title: "Oops!",
            message: "Something went wrong. Please, try again later."
        ))
    }
    
    func testReceiveItemListWhenGenerateSuccessfully() {
        // Arrange
        let generator = ListGeneratorSpy()
        let sut = BuildYourMealViewModel(generator: generator)
        sut.meal = "Some meal"
        sut.portion = "Some portion"
        let expectedList = GeneratedList(name: "Generated Meal", items: [])

        
        // Act
        sut.onTap()
        
        // Assert
        XCTAssertTrue(sut.isLoading)
        
        // Act: Simulate async list generation completion with success
        generator.completion?(.success(expectedList))
        
        // Assert
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.generatedList, expectedList)
    }
}

struct ErrorDummy: Error { }

final class ListGeneratorSpy: ListGenerator {
    var generateCalled = false
    var receivedInput: ListGeneratorInput?
    
    var completion: ((Result<GeneratedList, Error>) -> Void)?
    
    func generate(
        from input: ListGeneratorInput,
        completion: @escaping (Result<GeneratedList, Error>) -> Void
    ) {
        generateCalled = true
        receivedInput = input
        self.completion = completion
    }
}
