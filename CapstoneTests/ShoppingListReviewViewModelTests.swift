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
            list: GeneratedList.fixture(),
            userDefaults: defaults
        )
        
        XCTAssertTrue(defaults.shoppingLists.isEmpty)
    }
    
    func testAppendNewListOnConfirm() {
        let existingList = GeneratedList.fixture()
        defaults.shoppingLists = [
            existingList
        ]
        let newList = GeneratedList.fixture()
        
        let sut = ShoppingListReviewViewModel(
            list: newList,
            userDefaults: defaults
        )
        
        sut.onConfirm()
        
        XCTAssertEqual(defaults.shoppingLists, [existingList, newList])
    }
}
