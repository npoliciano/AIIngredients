//
//  UserDetailViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation
import Combine

final class UserDetailViewModel: ObservableObject {
    @Published var preferences: DietaryPreferences {
        didSet {
            userDefaults.dietaryPreferences = preferences
        }
    }
    
    @Published var userName: String
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.preferences = userDefaults.dietaryPreferences ?? DietaryPreferences(
            glutenFree: false,
            lactoseFree: false,
            sugarFree: false,
            vegan: false,
            vegetarian: false
        )
        self.userName = userDefaults.userName
    }
}
