//
//  UserNameViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import XCTest

@testable import Capstone

final class UserNameViewModelTests: XCTestCase {
  var defaults: UserDefaults!

  override func setUp() {
    super.setUp()

    defaults = UserDefaults(suiteName: #file)
    defaults.removePersistentDomain(forName: #file)
  }

  func testInitsWithValidData() {
    defaults.userName = "some name"
    let sut = UserNameViewModel(userDefaults: defaults)

    XCTAssertEqual(defaults.userName, "some name")
    XCTAssertEqual(sut.userName, "")
  }

  func testDoNotSaveWhenUserNameIsEmpty() {
    defaults.userName = "previous name"
    let sut = UserNameViewModel(userDefaults: defaults)

    sut.userName = ""

    sut.onTap()

    XCTAssertEqual(defaults.userName, "previous name")
  }

  func testSaveWhenUserNameIsNotEmpty() {
    defaults.userName = "previous name"
    let sut = UserNameViewModel(userDefaults: defaults)

    sut.userName = "new name"

    sut.onTap()

    XCTAssertEqual(defaults.userName, "new name")
  }
}
