//
//  ShoppingListViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import XCTest

@testable import Capstone

final class ShoppingListViewModelTests: XCTestCase {
    let defaults = UserDefaults(suiteName: "tests")!
    
    func testInit() {
        defaults.userName = "some user name"
        let existingList = GeneratedList(name: "some meal name", items: [
            Item(name: "some name", quantity: "some quantity")
        ])
        defaults.shoppingLists = [
            existingList
        ]
        
        _ = ShoppingListViewModel(userDefaults: defaults)
        
        XCTAssertEqual(defaults.userName, "some user name")
        XCTAssertEqual(defaults.shoppingLists[0].name, existingList.name)
        XCTAssertEqual(defaults.shoppingLists[0].items[0].name, existingList.items[0].name)
        XCTAssertEqual(defaults.shoppingLists[0].items[0].quantity, existingList.items[0].quantity)
    }
}
