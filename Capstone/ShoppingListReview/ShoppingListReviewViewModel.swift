//
//  ShoppingListReviewViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListReviewViewModel: ObservableObject {
    private let list: GeneratedList
    private let userDefaultsKey = "shoppingLists"
    
    var name: String {
        list.name
    }
    
    var items: [Item] {
        list.items
    }
    
    init(list: GeneratedList) {
        self.list = list
    }
    
    func onConfirm() {
        saveList()
    }
    
    private func saveList() {
        var allLists = loadLists()
        allLists.append(list)
        if let encoded = try? JSONEncoder().encode(allLists) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadLists() -> [GeneratedList] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedLists = try? JSONDecoder().decode([GeneratedList].self, from: data) {
            return savedLists
        }
        return []
    }
}
