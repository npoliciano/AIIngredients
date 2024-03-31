//
//  UserDefaults+Extensions.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 28/11/23.
//

import Foundation

extension UserDefaults {
  /// Mocking User Defaults:
  /// - Reference: https://www.swiftbysundell.com/tips/avoiding-mocking-userdefaults/
  static func testDefaults(fileName: String = #file) -> UserDefaults {
    // Disable it to simplify its usage. It will never fail and it's safe because it's in the test target.
    // swiftlint:disable:next force_unwrapping
    let defaults = UserDefaults(suiteName: fileName)!
    defaults.removePersistentDomain(forName: fileName)
    return defaults
  }
}
