//
//  ShoppingListReviewViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListReviewViewModel: ObservableObject {
    private let list: GeneratedList
    private let userDefaults: UserDefaults
    
    var name: String {
        list.name
    }
    
    var items: [Item] {
        list.items
    }
    
    init(list: GeneratedList, userDefaults: UserDefaults = .standard) {
        self.list = list
        self.userDefaults = userDefaults
    }
    
    func onConfirm() {
        saveList()
    }
    
    private func saveList() {
        var allLists = userDefaults.shoppingLists
        allLists.append(list)
        userDefaults.shoppingLists = allLists
        
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
}
