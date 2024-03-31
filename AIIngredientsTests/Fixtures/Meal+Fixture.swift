//
//  GeneratedList+Fixture.swift
//  AIIngredientsTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation

@testable import AIIngredients

extension Meal {
  /// Using fixtures to make the testes clearer
  /// - [See more](https://mokacoding.com/blog/streamlining-tests-setup-with-fixtures-in-swift/)
  static func fixture(
    id: UUID = UUID(),
    name: String = "",
    categories: [AIIngredients.Category] = [],
    ingredients: [Ingredient] = []
  ) -> Meal {
    Meal(id: id, name: name, categories: categories, ingredients: ingredients)
  }
}
