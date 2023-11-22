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
    
    func testCompleteWithErrorOnFailurePost() throws {
        // Arrange
        let client = HTTPClientSpy()
        let sut = OpenAIListGenerator(httpClient: client)
        client.errorToBeThrown = ErrorDummy()
        
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
    
    var errorToBeThrown = ErrorDummy()
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
