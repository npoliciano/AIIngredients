//
//  ShoppingListReviewViewModelTests.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import XCTest

@testable import Capstone

final class ShoppingListReviewViewModelTests: XCTestCase {
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        defaults = UserDefaults(suiteName: #file)
        defaults.removePersistentDomain(forName: #file)
    }
    
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
        
        XCTAssertEqual(defaults.shoppingLists, [existingList, newList])
    }
}
