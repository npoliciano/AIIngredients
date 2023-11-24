//
//  DietaryPreferences.swift
//  Capstone
//
//  Created by Nicolle on 19/11/23.
//

import Foundation

struct DietaryPreferences: Codable, Equatable {
    var glutenFree: Bool
    var lactoseFree: Bool
    var sugarFree: Bool
    var vegan: Bool
    var vegetarian: Bool
}
