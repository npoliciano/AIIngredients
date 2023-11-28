//
//  MealJSON.swift
//  Capstone
//
//  Created by Nicolle on 25/11/23.
//

import Foundation

struct MealJSON: Decodable, Equatable {
  let mealName: String
  var categories: [CategoryJSON]
  let ingredients: [IngredientJSON]

  enum CodingKeys: CodingKey {
    case mealName
    case categories
    case ingredients
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.mealName = try container.decode(String.self, forKey: .mealName)
    self.categories = (try? container.decode([CategoryJSON].self, forKey: .categories)) ?? []
    self.ingredients = try container.decode([IngredientJSON].self, forKey: .ingredients)
  }
}

enum CategoryJSON: String, Decodable {
  case proteins = "PROTEINS"
  case carbo = "GRAINS_AND_CARBOHYDRATES"
  case veggies = "FRUITS_AND_VEGETABLES"
  case dairy = "DAIRY_AND_ALTERNATIVES"
  case seasonings = "SEASONINGS_AND_CONDIMENTS"
  case unknown

  init(from decoder: Decoder) throws {
    let value = try decoder.singleValueContainer().decode(String.self)
    self = CategoryJSON(rawValue: value) ?? .unknown
  }
}

struct IngredientJSON: Decodable, Equatable {
  let name: String
  let quantity: String
}

extension Meal {
  init(json: MealJSON) {
    self.id = UUID()
    self.name = json.mealName
    self.ingredients = json.ingredients.map { Ingredient(json: $0) }
    // Eliminate duplicates and unknowns
    self.categories = Array(Set(json.categories.compactMap { Category(json: $0) })).sorted { lhs, rhs in
      lhs.sortOrder < rhs.sortOrder
    }
  }
}

extension Category {
  init?(json: CategoryJSON) {
    switch json {
    case .proteins:
      self = .proteins
    case .carbo:
      self = .carbo
    case .veggies:
      self = .veggies
    case .dairy:
      self = .dairy
    case .seasonings:
      self = .seasonings
    case .unknown:
      return nil
    }
  }
}

extension Category {
  var sortOrder: Int {
    switch self {
    case .proteins:
      return 0
    case .carbo:
      return 1
    case .veggies:
      return 2
    case .dairy:
      return 3
    case .seasonings:
      return 4
    }
  }
}

extension Ingredient {
  init(json: IngredientJSON) {
    self.id = UUID()
    self.name = json.name
    self.quantity = json.quantity
    self.isSelected = false
  }
}
