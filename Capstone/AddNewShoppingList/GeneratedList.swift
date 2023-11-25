//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct GeneratedList: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    var items: [Item]
    var isSelected: Bool = false
    
    init(id: UUID = UUID(), name: String, items: [Item]) {
        self.id = id
        self.name = name
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "mealName"
        case items
    }
}

struct Item: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    var name: String
    var quantity: String
    
    init(id: UUID = UUID(), name: String, quantity: String) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
}
