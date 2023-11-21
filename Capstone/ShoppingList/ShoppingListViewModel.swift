//
//  ShoppingListViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: [GeneratedList] = []
    
    private let userDefaultsKey = "shoppingLists"
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadLists), name: Notification.Name("onUpdateShoppingList"), object: nil)
        loadLists()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func loadLists() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedLists = try? JSONDecoder().decode([GeneratedList].self, from: data) {
            shoppingList = savedLists
        } else {
            shoppingList = []
        }
    }
}
