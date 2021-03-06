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
    
    func testGetJots() {
        let jot = Jot(id: 0, data: "hi", queue: true, createdAt: "", modifiedAt: "", latitude: nil, longitude: nil)
        let ji = JotInitiative(jotId: 0, initiativeTag: "ayyy")
        let jot1 = Jot(id: 1, data: "bye", queue: true, createdAt: "", modifiedAt: "", latitude: nil, longitude: nil)
        let ji1 = JotInitiative(jotId: 1, initiativeTag: "ayyy")
        let jot2 = Jot(id: 2, data: "hi", queue: true, createdAt: "", modifiedAt: "", latitude: nil, longitude: nil)
        let ji2 = JotInitiative(jotId: 2, initiativeTag: "asdf")
        jot.write()
        jot1.write()
        jot2.write()
        ji.write()
        ji1.write()
        ji2.write()
        let ayyy = [jot, jot1]
        let asdf = [jot2]
        
        XCTAssertEqual(JotInitiative.getJots(initiative: "ayyy"), ayyy)
        XCTAssertEqual(JotInitiative.getJots(initiative: "asdf"), asdf)
    }
}
