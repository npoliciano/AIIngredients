//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct Recipes: Identifiable {
    let id = UUID()
    
    let name: String
    let items: [Items]
}

struct Items {
    let name: String
    let quantity: String
}
