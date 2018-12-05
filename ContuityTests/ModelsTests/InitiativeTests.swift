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
    
    override func setUp() {
        // Create tables
    }
    
    override func tearDown() {
        // Delete tables here
        let tableName = "initiative"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
    }
    
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
        let initiatives = [init1, Initiative(name: "bye", parent: "NULL")]
        
        XCTAssertEqual(Initiative.initiatives, initiatives)
    }
    
    func testEditDistance() {
        let init1 = Initiative(name: "beast", parent: "")
        let init2 = Initiative(name: "sitting", parent: "")
        
        XCTAssertEqual(init1.editDistance(givenName: "pert"), 3)
        XCTAssertEqual(init2.editDistance(givenName: "smitten"), 3)
    }
    
    func testSimilarity() {
        let init1 = Initiative(name: "beast", parent: "")
        let init3 = Initiative(name: "pert", parent: "")
        let init2 = Initiative(name: "sitting", parent: "")
        let init4 = Initiative(name: "sittin", parent: "")
        
        XCTAssertEqual(init1.similarInitiative(givenInitiative: init3), false)
        XCTAssertEqual(init2.similarInitiative(givenInitiative: init4), true)
    }
}
