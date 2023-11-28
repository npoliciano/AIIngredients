//
//  CapstoneTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 14/11/23.
//

import XCTest

@testable import Capstone

final class URLSessionHTTPClientTests: XCTestCase {
  var sut: URLSessionHTTPClient!
  let expectedAuthorizationKey = "some authorization"

  override func setUp() {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [URLProtocolSpy.self]

    sut = URLSessionHTTPClient(
      urlSession: URLSession(configuration: configuration),
      authorizationKey: expectedAuthorizationKey
    )
  }

  func testDoNotStartOnInit() {
    // Assert
    XCTAssertFalse(URLProtocolSpy.startLoadingCalled)
  }

  func testAssemblesValidURLRequest() async throws {
    // Arrange
    let url = URL(filePath: "any")
    let body = Data("some body".utf8)

    // Act
    _ = try? await sut.post(from: url, body: body)

    // Assert
    let requestReceived = try XCTUnwrap(URLProtocolSpy.requestReceived)

    XCTAssertEqual(requestReceived.url?.absoluteString, url.absoluteString)
    XCTAssertEqual(requestReceived.httpMethod, "POST")
    XCTAssertEqual(requestReceived.allHTTPHeaderFields?["Authorization"], "Bearer \(expectedAuthorizationKey)")
    XCTAssertEqual(requestReceived.allHTTPHeaderFields?["Content-Type"], "application/json")
  }

  func testThrowsErrorWhenStatusCodeIsNotSuccessful() async {
    // Arrange
    URLProtocolSpy.dataToBeReturned = Data(
    """
      {
        "list": "some list"
      }
    """.utf8)
    URLProtocolSpy.statusCodeToBeReturned = 300

    let url = URL(filePath: "any")
    let body = Data("some body".utf8)

    // Act
    do {
      _ = try await sut.post(from: url, body: body)

      // Assert
      XCTFail("Got data, expected AppError.server")
    } catch {
      // Assert
      XCTAssertEqual(error as? AppError, .server)
    }
    XCTAssertTrue(URLProtocolSpy.startLoadingCalled)
  }

  func testThrowsErrorWhenThereIsNetworkError() async {
    // Arrange
    URLProtocolSpy.shouldSimulateNetworkError()
    // Ensuring that status code is ignored when there is a network error
    URLProtocolSpy.statusCodeToBeReturned = 200

    let url = URL(filePath: "any")
    let body = Data("some body".utf8)

    // Act
    do {
      _ = try await sut.post(from: url, body: body)

      // Assert
      XCTFail("Got data, expected AppError.network")
    } catch {
      // Assert
      XCTAssertEqual(error as? AppError, .network)
    }
    XCTAssertTrue(URLProtocolSpy.startLoadingCalled)
  }

  func testReturnsData() async throws {
    // Arrange
    let expectedData = Data(
    """
      {
        "list": "some list"
      }
    """.utf8)

    URLProtocolSpy.statusCodeToBeReturned = 200
    URLProtocolSpy.dataToBeReturned = expectedData

    let url = URL(filePath: "any")
    let body = Data("some body".utf8)

    // Act
    let data = try? await sut.post(from: url, body: body)

    // Assert
    XCTAssertEqual(data, expectedData)
    XCTAssertTrue(URLProtocolSpy.startLoadingCalled)
  }

  override func tearDown() {
    URLProtocolSpy.dataToBeReturned = nil
    URLProtocolSpy.statusCodeToBeReturned = 200
    URLProtocolSpy.requestReceived = nil
    URLProtocolSpy.startLoadingCalled = false
  }
}

final class URLProtocolSpy: URLProtocol {
  struct ErrorDummy: Error { }

  static var requestReceived: URLRequest?
  static var startLoadingCalled = false
  static var dataToBeReturned: Data?
  static var statusCodeToBeReturned = 200

  static func shouldSimulateNetworkError() {
    dataToBeReturned = nil
  }

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    guard let client = client, let url = request.url, let response = HTTPURLResponse(
      url: url,
      statusCode: Self.statusCodeToBeReturned,
      httpVersion: nil,
      headerFields: nil
    ) else { fatalError("Client or URL missing") }

    Self.requestReceived = request
    Self.startLoadingCalled = true

    client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

    if let data = Self.dataToBeReturned {
      client.urlProtocol(self, didLoad: data)
    } else {
      client.urlProtocol(self, didFailWithError: ErrorDummy())
    }

    client.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() { }
}
