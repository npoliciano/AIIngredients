//
//  GeneratedList+Fixture.swift
//  CapstoneTests
//
//  Created by Nicolle on 23/11/23.
//

import Foundation

@testable import Capstone

extension GeneratedList {
    /// Using fixtures to make the testes clearer
    /// - [See more](https://mokacoding.com/blog/streamlining-tests-setup-with-fixtures-in-swift/)
    static func fixture(id: UUID = UUID(), name: String = "", items: [Item] = []) -> GeneratedList {
        GeneratedList(id: id, name: name, items: items)
    }
}
