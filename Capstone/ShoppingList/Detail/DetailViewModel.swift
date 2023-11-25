//
//  DetailViewModel.swift
//  Capstone
//
//  Created by Nicolle on 23/11/23.
//

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
    @Published var meal: Meal {
        didSet {
            var allMeals = userDefaults.shoppingLists

            guard let index = allMeals.firstIndex(where: { $0.id == meal.id }) else {
                return
            }

            var storedMeal = allMeals[index]

            for ingredient in meal.ingredients {
                storedMeal.ingredients = storedMeal.ingredients.map {
                    if $0.id == ingredient.id {
                        var storedIngredient = $0
                        storedIngredient.isSelected = ingredient.isSelected
                        return storedIngredient
                    }
                    return $0
                }
            }

            allMeals[index] = storedMeal
            saveAndNotify(updatedList: allMeals)
        }
    }
    
    private let userDefaults: UserDefaults
    
    init(meal: Meal, userDefaults: UserDefaults = .standard) {
        self.meal = meal
        self.userDefaults = userDefaults
    }
    
    func updateList() {
        var allMeals = userDefaults.shoppingLists
        
        guard let index = allMeals.firstIndex(where: { $0.id == meal.id }) else {
            return
        }
        
        allMeals[index] = meal
        
        saveAndNotify(updatedList: allMeals)
    }
    
    func delete() {
        var allMeals = userDefaults.shoppingLists
        allMeals.removeAll { $0.id == meal.id }
        
        saveAndNotify(updatedList: allMeals)
    }
    
    private func saveAndNotify(updatedList: [Meal]) {
        userDefaults.shoppingLists = updatedList
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
}
   
