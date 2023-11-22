//
//  UserPreferencesViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class UserPreferencesViewModel: ObservableObject {
    @Published var preferences = DietaryPreferences(
        glutenFree: false,
        lactoseFree: false,
        sugarFree: false,
        vegan: false,
        vegetarian: false
    )
    
    func onTap() {
        UserDefaults.standard.dietaryPreferences = preferences
    }
}
