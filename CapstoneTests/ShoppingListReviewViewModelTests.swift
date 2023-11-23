//
//  ShoppingListReviewViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import XCTest

@testable import Capstone

final class ShoppingListReviewViewModelTests: XCTestCase {
    let defaults = UserDefaults(suiteName: "tests")!
    
    func testInitDoesNotSaveTheList() {
        
        defaults.shoppingLists = []
        _ = ShoppingListReviewViewModel(
            list: GeneratedList(name: "some name", items: []),
            userDefaults: defaults
        )
        
        XCTAssertTrue(defaults.shoppingLists.isEmpty)
    }
    
    func testAppendNewListOnConfirm() {
        let existingList = GeneratedList(name: "some meal name", items: [Item(name: "some name", quantity: "some quantity")])
        defaults.shoppingLists = [
            existingList
        ]
        let newList = GeneratedList(name: "some meal name 2", items: [Item(name: "some name 2", quantity: "some quantity 2")])
        
        let sut = ShoppingListReviewViewModel(
            list: newList,
            userDefaults: defaults
        )
        
        sut.onConfirm()
        
        XCTAssertEqual(defaults.shoppingLists[0].name, existingList.name)
        XCTAssertEqual(defaults.shoppingLists[0].items[0].name, existingList.items[0].name)
        XCTAssertEqual(defaults.shoppingLists[0].items[0].quantity, existingList.items[0].quantity)
        XCTAssertEqual(defaults.shoppingLists[0].items.count, 1)
        
        XCTAssertEqual(defaults.shoppingLists[1].name, newList.name)
        XCTAssertEqual(defaults.shoppingLists[1].items[0].name, newList.items[0].name)
        XCTAssertEqual(defaults.shoppingLists[1].items[0].quantity, newList.items[0].quantity)
        XCTAssertEqual(defaults.shoppingLists[1].items.count, 1)
        
        XCTAssertEqual(defaults.shoppingLists.count, 2)
    }
    
    
}
