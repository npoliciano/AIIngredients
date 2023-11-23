//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct GeneratedList: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    
    let name: String
    var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case name = "mealName"
        case items
    }
}

struct Item: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    
    var name: String
    let quantity: String
    
    enum CodingKeys: CodingKey {
        case name
        case quantity
    }
}
