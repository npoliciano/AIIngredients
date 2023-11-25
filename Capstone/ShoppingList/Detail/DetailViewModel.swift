//
//  DetailViewModel.swift
//  Capstone
//
//  Created by Nicolle on 23/11/23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var meal: Meal
    
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
        
        userDefaults.shoppingLists = allMeals
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
    
    func delete() {
        var allMeals = userDefaults.shoppingLists
        allMeals.removeAll { $0.id == meal.id }
        
        userDefaults.shoppingLists = allMeals
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
}
   
