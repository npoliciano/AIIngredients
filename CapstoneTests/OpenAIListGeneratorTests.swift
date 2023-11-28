//
//  OpenAIListGenerator.swift
//  CapstoneTests
//
//  Created by Nicolle on 19/11/23.
//

import XCTest

@testable import Capstone

final class OpenAIListGeneratorTests: XCTestCase {
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        defaults = UserDefaults(suiteName: #file)
        defaults.removePersistentDomain(forName: #file)
        defaults.dietaryPreferences = preferences
    }
    
    func testInitDoesNotPerformAnyRequest() {
        // Arrange & Act
        let client = HTTPClientSpy()
        _ = OpenAIListGenerator(httpClient: client, preferences: preferences)
        
        // Assert
        XCTAssertFalse(client.postCalled)
    }
    
    func testProvidesValidURLAndBody() throws {
        // Arrange & Act
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        sut.generate(from: input) { _ in
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        XCTAssertEqual(client.urlReceived, URL(string: "https://api.openai.com/v1/chat/completions"))
        XCTAssertEqual(client.bodyReceived?.jsonDict, expectedBodyData.jsonDict)
    }
    
    func testCompletesWithErrorWhenClientThrowsNetworkError() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        client.errorToBeThrown = AppError.network
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<Meal, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        XCTAssertThrowsError(try receivedResult?.get()) { error in
            XCTAssertEqual(error as? AppError, .network)
        }
    }
    
    func testCompletesWithErrorWhenClientThrowsServerError() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        client.errorToBeThrown = AppError.server
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<Meal, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        XCTAssertThrowsError(try receivedResult?.get()) { error in
            XCTAssertEqual(error as? AppError, .server)
        }
    }
    
    func testFailsToDecode() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        let invalidData = Data()
        client.dataToBeReturned = invalidData
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<Meal, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        XCTAssertThrowsError(try receivedResult?.get())
    }
    
    func testFailsWhenThereIsNoChoice() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        client.dataToBeReturned = Data("""
        {
            "choices": []
        }
        """.utf8)
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<Meal, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        XCTAssertThrowsError(try receivedResult?.get()) { error in
            XCTAssertEqual(error as? AppError, .server)
        }
    }
    
    func testReturnsGeneratedMealSuccessfuly() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        
        client.dataToBeReturned = Data("""
        {
            "choices": [
                {
                    "message": {
                        "content": "{\\"mealName\\":\\"Some meal\\",\\"categories\\":[\\"PROTEINS\\", \\"GRAINS_AND_CARBOHYDRATES\\"],\\"ingredients\\": [{\\"name\\":\\"Some ingredient\\",\\"quantity\\":\\"4g\\"}]}"
                    }
                }
            ]
        }
        """.utf8)
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<Meal, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        let generatedMeal = try receivedResult?.get()
        
        XCTAssertEqual(generatedMeal?.name, "Some meal")
        // Should have valid sorted categories
        XCTAssertEqual(generatedMeal?.categories, [.proteins, .carbo])
        XCTAssertEqual(generatedMeal?.ingredients[0].name, "Some ingredient")
        XCTAssertEqual(generatedMeal?.ingredients[0].quantity, "4g")
        XCTAssertEqual(generatedMeal?.ingredients.count, 1)
    }
    
    // Categories tests
    
    func testHandlesCategoriesProperly() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client, preferences: preferences)
        
        client.dataToBeReturned = Data("""
        {
            "choices": [
                {
                    "message": {
                        "content": "{\\"mealName\\":\\"Some meal\\",\\"categories\\":[\\"INVALID\\", \\"GRAINS_AND_CARBOHYDRATES\\", \\"PROTEINS\\", \\"SEASONINGS_AND_CONDIMENTS\\", \\"PROTEINS\\", \\"FRUITS_AND_VEGETABLES\\", \\"DAIRY_AND_ALTERNATIVES\\"],\\"ingredients\\": [{\\"name\\":\\"Some ingredient\\",\\"quantity\\":\\"4g\\"}]}"
                    }
                }
            ]
        }
        """.utf8)
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<Meal, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        let generatedMeal = try receivedResult?.get()
        // Should sort and eliminate repeated and unknown values
        XCTAssertEqual(generatedMeal?.categories, [.proteins, .carbo, .veggies, .dairy, .seasonings])
    }
    
    // MARK: Helpers
    
    private var preferences: DietaryPreferences {
        DietaryPreferences(glutenFree: true, lactoseFree: false, sugarFree: true, vegan: false, vegetarian: true)
    }
    
    private var input: ListGeneratorInput {
        ListGeneratorInput(meal: "some meal", portion: "some portion", measurement: Measurements.litres, quantity: 2)
    }
    
    private var expectedBodyData: Data {
        let requestBody = OpenAIRequestBody(messages: [
            .init(content: input.prompt(preferences: preferences))
        ])
        return try! JSONEncoder().encode(requestBody)
    }
}

final class HTTPClientSpy: HTTPClient {
    private(set) var postCalled = false
    private(set) var urlReceived: URL?
    private(set) var bodyReceived: Data?
    
    var errorToBeThrown: Error = ErrorDummy()
    var dataToBeReturned: Data?
    
    func post(from url: URL, body: Data) async throws -> Data {
        postCalled = true
        urlReceived = url
        bodyReceived = body
        
        guard let dataToBeReturned else {
            throw errorToBeThrown
        }
        
        return dataToBeReturned
    }
}

extension Data {
    var jsonDict: [String: String]? {
        return try? JSONSerialization.jsonObject(with: self, options: []) as? [String: String]
    }
}
