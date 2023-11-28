//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct Meal: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    let categories: [Category]
    var ingredients: [Ingredient]

    init(id: UUID = UUID(), name: String, categories: [Category], ingredients: [Ingredient]) {
        self.id = id
        self.name = name
        self.categories = categories
        self.ingredients = ingredients
    }
}

enum Category: Codable {
    case proteins
    case carbo
    case veggies
    case dairy
    case seasonings
}

struct Ingredient: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    var quantity: String
    var isSelected: Bool

    init(id: UUID = UUID(), name: String, quantity: String, isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.isSelected = isSelected
    }
}
