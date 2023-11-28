//
//  OnboardingFlowViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import XCTest

@testable import Capstone

final class OnboardingFlowViewModelTests: XCTestCase {
  let defaults = UserDefaults.testDefaults()

  func testInitsWithValidData() {
    defaults.onboardingStatus = .pendingName
    let sut = OnboardingFlowViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.onboardingStatus, .pendingName)
  }

  func testMoveToTheNextStep() {
    defaults.onboardingStatus = .none
    let sut = OnboardingFlowViewModel(userDefaults: defaults)

    XCTAssertEqual(sut.onboardingStatus, .none)

    sut.nextStep()

    XCTAssertEqual(sut.onboardingStatus, .pendingName)
    XCTAssertEqual(defaults.onboardingStatus, .pendingName)

    sut.nextStep()

    XCTAssertEqual(sut.onboardingStatus, .pendingPreferences)
    XCTAssertEqual(defaults.onboardingStatus, .pendingPreferences)

    sut.nextStep()

    XCTAssertEqual(sut.onboardingStatus, .complete)
    XCTAssertEqual(defaults.onboardingStatus, .complete)

    sut.nextStep()

    XCTAssertEqual(sut.onboardingStatus, .complete)
    XCTAssertEqual(defaults.onboardingStatus, .complete)
  }
}
