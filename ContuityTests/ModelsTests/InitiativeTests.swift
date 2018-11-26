//
//  InitiativeTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/29/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class InitiativeTests: XCTestCase {

    func testEquatable() {
        let init1 = Initiative(name: "hello", parent: "NEIN")
        let init2 = Initiative(name: "hello", parent: "JA")

        XCTAssertEqual(init1, init1)
        XCTAssertNotEqual(init1, init2)
    }

    func testWrite() {
        let init1 = Initiative(name: "hello", parent: "NEIN")
        init1.write()

        let statement = try! DatabaseManager.shared.conn?.prepare("SELECT * FROM initiative")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 2)
        XCTAssertEqual(statement?.columnNames, ["name", "parent"])
    }
    
    func testGetInitiatives() {
        let init1 = Initiative(name: "hello", parent: "NEIN")
        let init2 = Initiative(name: "bye", parent: nil)
        init1.write()
        init2.write()
        let initiatives = [init1, init2]
        
        XCTAssertEqual(try Initiative.getInitiatives(), initiatives)
    }
}
