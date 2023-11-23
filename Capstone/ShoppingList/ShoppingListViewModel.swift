//
//  ShoppingListViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: [GeneratedList] = []
    var userName = UserDefaults.standard.userName ?? ""
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadLists), name: Notification.Name("onUpdateShoppingList"), object: nil)
        loadLists()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func loadLists() {
        shoppingList = UserDefaults.standard.shoppingLists.reversed()
    }
}
