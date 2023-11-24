//
//  ShoppingListViewModel.swift
//  Capstone
//
//  Created by Nicolle on 21/11/23.
//

import Foundation

final class ShoppingListViewModel: ObservableObject {
    @Published var shoppingLists: [GeneratedList] = []
    var userName: String
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        userName = userDefaults.userName
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadLists),
            name: .onUpdateShoppingList,
            object: nil
        )
        loadLists()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func loadLists() {
        shoppingLists = userDefaults.shoppingLists.reversed()
    }
}
