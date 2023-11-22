//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct GeneratedList: Codable, Identifiable, Equatable {
    let id = UUID()
    
    let name: String
    let items: [Item]
    
    enum CodingKeys: CodingKey {
        case name
        case items
    }
}

struct Item: Codable, Identifiable, Equatable {
    let id = UUID()
    
    let name: String
    let quantity: String
    
    enum CodingKeys: CodingKey {
        case name
        case quantity
    }
}
