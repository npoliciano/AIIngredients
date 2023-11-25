//
//  DetailViewModel.swift
//  Capstone
//
//  Created by Nicolle on 23/11/23.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var list: GeneratedList
    
    private let userDefaults: UserDefaults
    
    init(list: GeneratedList, userDefaults: UserDefaults = .standard) {
        self.list = list
        self.userDefaults = userDefaults
    }
    
    func updateList() {
        var allLists = userDefaults.shoppingLists
        
        guard let index = allLists.firstIndex(where: { $0.id == list.id }) else {
            return
        }
        
        allLists[index] = list
        
        userDefaults.shoppingLists = allLists
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
    
    func delete() {
        var allLists = userDefaults.shoppingLists
        allLists.removeAll { $0.id == list.id }
        
        userDefaults.shoppingLists = allLists
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
}
   
