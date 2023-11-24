//
//  ShoppingListViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import XCTest

@testable import Capstone

final class ShoppingListViewModelTests: XCTestCase {
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        defaults = UserDefaults(suiteName: #file)
        defaults.removePersistentDomain(forName: #file)
    }
    
    func testInit() {
        defaults.userName = "some user name"
        let existingList = GeneratedList(name: "some meal name", items: [
            Item(name: "some name", quantity: "some quantity")
        ])
        defaults.shoppingLists = [existingList]
        
        let sut = ShoppingListViewModel(userDefaults: defaults)
        
        XCTAssertEqual(sut.userName, "some user name")
        XCTAssertEqual(sut.shoppingList, [existingList])
    }
}
