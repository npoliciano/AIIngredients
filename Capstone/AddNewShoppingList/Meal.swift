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
    var ingredients: [Ingredient]
    
    init(id: UUID = UUID(), name: String, ingredients: [Ingredient]) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "mealName"
        case ingredients
    }
}

struct Ingredient: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    var quantity: String
    
    init(id: UUID = UUID(), name: String, quantity: String) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
}
