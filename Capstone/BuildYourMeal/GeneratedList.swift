//
//  Recipes.swift
//  Capstone
//
//  Created by Nicolle on 14/11/23.
//

import Foundation

struct GeneratedList: Equatable {
    let name: String
    let items: [Item]
}

struct Item: Equatable {
    let name: String
    let quantity: String
}
