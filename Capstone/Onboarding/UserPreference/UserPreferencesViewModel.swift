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
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func onTap() {
        userDefaults.dietaryPreferences = preferences
    }
}
