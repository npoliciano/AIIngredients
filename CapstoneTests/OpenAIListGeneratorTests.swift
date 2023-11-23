//
//  OpenAIListGenerator.swift
//  CapstoneTests
//
//  Created by Nicolle on 19/11/23.
//

import XCTest

@testable import Capstone

final class OpenAIListGeneratorTests: XCTestCase {
    func testInitDoesNotPerformAnyRequest() {
        // Arrange & Act
        let client = HTTPClientSpy()
        _ = OpenAIListGenerator(httpClient: client)
        
        // Assert
        XCTAssertFalse(client.postCalled)
    }
    
    func testProvidesValidURLAndBody() throws {
        // Arrange & Act
        UserDefaults.standard.dietaryPreferences = preferences
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client)
        
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
        XCTAssertEqual(client.bodyReceived, expectedBodyData)
    }
    
    func testCompletesWithErrorWhenClientThrowsNetworkError() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client)
        client.errorToBeThrown = AppError.network
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<GeneratedList, Error>?
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
        let sut = OpenAIListGenerator(httpClient: client)
        client.errorToBeThrown = AppError.server
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<GeneratedList, Error>?
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
        let sut = OpenAIListGenerator(httpClient: client)
        let invalidData = Data()
        client.dataToBeReturned = invalidData
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<GeneratedList, Error>?
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
        let sut = OpenAIListGenerator(httpClient: client)
        client.dataToBeReturned = Data("""
        {
            "choices": []
        }
        """.utf8)
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<GeneratedList, Error>?
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
    
    func testReturnsGeneratedListSuccessfuly() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client)
        
        client.dataToBeReturned = Data("""
        {
            "choices": [
                {
                    "message": {
                        "content": "{\\"mealName\\":\\"Some meal\\",\\"items\\": [{\\"name\\":\\"Some ingredient\\",\\"quantity\\":\\"4g\\"}]}"
                    }
                }
            ]
        }
        """.utf8)
        
        // used because the Task completes after this test method returns
        let expectation = expectation(description: "wait for response")
        
        // Act
        var receivedResult: Result<GeneratedList, Error>?
        sut.generate(from: input) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation])
        
        XCTAssertTrue(client.postCalled)
        let generatedList = try receivedResult?.get()
        
        XCTAssertEqual(generatedList?.name, "Some meal")
        XCTAssertEqual(generatedList?.items[0].name, "Some ingredient")
        XCTAssertEqual(generatedList?.items[0].quantity, "4g")
        XCTAssertEqual(generatedList?.items.count, 1)
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
