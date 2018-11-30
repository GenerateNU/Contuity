//
//  JotInitiativeTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/29/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import SQLite
import XCTest
@testable import Contuity

class JotInitiativeTests: XCTestCase {
    
    override func setUp() {
        // Create tables
    }
    
    override func tearDown() {
        // Delete tables here
        let tableName = "jotinitiative"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
    }
    
    func testEquatable() {
        let ji1 = JotInitiative(jotId: 0, initiativeTag: "hello")
        let ji2 = JotInitiative(jotId: 1, initiativeTag: "world")

        XCTAssertEqual(ji1, ji1)
        XCTAssertNotEqual(ji1, ji2)
    }

    func testWrite() {
        let ji = JotInitiative(jotId: 0, initiativeTag: "ayyy")
        ji.write()

        let statement = try! DatabaseManager.shared.conn?.prepare("SELECT * FROM jotinitiative")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 2)
        XCTAssertEqual(statement?.columnNames, ["jotid", "initiativeid"])
    }
}
