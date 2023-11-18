//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct GeneratedList: Identifiable, Equatable {
    let id = UUID()
    
    let name: String
    let items: [Item]
}

struct Item: Identifiable, Equatable {
    let id = UUID()
    
    let name: String
    let quantity: String
}
