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
        let item = Item.fixture()
        let sut = ShoppingListReviewViewModel(
            list: GeneratedList.fixture(name: "some name", items: [item]),
            userDefaults: defaults
        )
        
        XCTAssertTrue(defaults.shoppingLists.isEmpty)
        XCTAssertEqual(sut.name, "some name")
        XCTAssertEqual(sut.items, [item])
    }
    
    func testAppendNewListOnConfirm() {
        let existingList = GeneratedList.fixture()
        defaults.shoppingLists = [existingList]
        let newList = GeneratedList.fixture()
        
        let sut = ShoppingListReviewViewModel(
            list: newList,
            userDefaults: defaults
        )
        expectation(
            forNotification: .onUpdateShoppingList,
            object: nil,
            handler: { _ in true }
        )
        
        sut.onConfirm()
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(defaults.shoppingLists, [existingList, newList])
    }
}
