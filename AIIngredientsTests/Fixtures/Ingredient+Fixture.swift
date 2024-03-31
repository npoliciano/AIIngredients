//
//  Item+Fixture.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation

@testable import AIIngredients

extension Ingredient {
  /// Using fixtures to make the testes clearer
  /// - [See more](https://mokacoding.com/blog/streamlining-tests-setup-with-fixtures-in-swift/)
  static func fixture(id: UUID = UUID(), name: String = "", quantity: String = "") -> Ingredient {
    Ingredient(id: id, name: name, quantity: quantity)
  }
}
