//
//  UserDefaultExtensions.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

extension UserDefaults {
    var userName: String? {
        get {
            self.string(forKey: "userName")
        }
        set {
            self.set(newValue, forKey: "userName")
        }
    }
    
    var dietaryPreferences: DietaryPreferences? {
        get {
            if let data = self.data(forKey: "dietaryPreferences"),
               let savedPreferences = try? JSONDecoder().decode(DietaryPreferences.self, from: data) {
                return savedPreferences
            }
            return nil
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                self.set(encoded, forKey: "dietaryPreferences")
            }
        }
    }
    
    
    var shoppingLists: [GeneratedList] {
        get {
            if let data = self.data(forKey: "shoppingLists"),
               let savedLists = try? JSONDecoder().decode([GeneratedList].self, from: data) {
                return savedLists
            }
            return []
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                self.set(encoded, forKey: "shoppingLists")
            }
        }
    }
}
