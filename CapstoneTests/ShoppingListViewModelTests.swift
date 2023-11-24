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
        
        // Mocking User Defaults:
        // - Reference: https://www.swiftbysundell.com/tips/avoiding-mocking-userdefaults/
        defaults = UserDefaults(suiteName: #file)
        defaults.removePersistentDomain(forName: #file)
    }
    
    func testInitWithValidData() {
        defaults.userName = "some user name"
        let existingList = GeneratedList.fixture()
        defaults.shoppingLists = [existingList]
        
        let sut = ShoppingListViewModel(userDefaults: defaults)
        
        XCTAssertEqual(sut.userName, "some user name")
        XCTAssertEqual(sut.shoppingLists, [existingList])
    }
    
    func testReactsToNotifications() {
        let sut = ShoppingListViewModel(userDefaults: defaults)
        
        XCTAssertEqual(sut.shoppingLists, [])
        
        let newList1 = GeneratedList.fixture()
        simulateUpdateShoppingList(newList1)
        
        XCTAssertEqual(sut.shoppingLists, [newList1])
        
        let newList2 = GeneratedList.fixture()
        
        simulateUpdateShoppingList(newList2)
        
        XCTAssertEqual(sut.shoppingLists, [newList2, newList1])
    }
    
    private func simulateUpdateShoppingList(_ list: GeneratedList) {
        defaults.shoppingLists.append(list)
        NotificationCenter.default.post(
            name: .onUpdateShoppingList,
            object: nil
        )
    }
}