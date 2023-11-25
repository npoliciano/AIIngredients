//
//  MealJSON.swift
//  Capstone
//
//  Created by Nicolle on 25/11/23.
//

import Foundation

struct MealJSON: Decodable, Equatable {
    let mealName: String
    let ingredients: [IngredientJSON]
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
