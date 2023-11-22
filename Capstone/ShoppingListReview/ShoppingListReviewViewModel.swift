//
//  ShoppingListReviewViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListReviewViewModel: ObservableObject {
    private let list: GeneratedList
    
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
        var allLists = UserDefaults.standard.shoppingLists
        allLists.append(list)
        UserDefaults.standard.shoppingLists = allLists
        NotificationCenter.default.post(
            name: Notification.Name("onUpdateShoppingList"),
            object: nil
        )
    }
}
