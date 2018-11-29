//
//  JotTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/17/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class JotTests: XCTestCase {

    override func setUp() {
        // Create tables
    }
    
    override func tearDown() {
        // Delete tables here
        let tableName = "jot"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
    }
    
    // This is a test for the implementation of the equatable protocol in Jot
    func testEquatable() {
        let jot1 = Jot(id: 0, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)
        let jot2 = Jot(id: 1, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)

        XCTAssertEqual(jot1, jot1)
        XCTAssertNotEqual(jot1, jot2)
    }

    // This is a test for the write function in the class Jot
    func testWrite() {
        let jot1 = Jot(id: -1, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: 20, longitude: nil)
        jot1.write()

        let statement = try! DatabaseManager.shared.conn?.prepare("SELECT * FROM jot")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 7)
        XCTAssertEqual(statement?.columnNames, ["id", "data", "queue", "createdAt", "modifiedAt", "latitude", "longitude"])
    }
    
    // This is a test for the read function in the class Jot
    func testRead() {
        let text1: String = "Whoa, I can't believe this works"
        let text2: String = "The text for jot2"
        let text3: String = "Scuba diving with the squad #funtimes"
        let now = "now"
        let jot1 = Jot(id: 4, data: text1, queue: false, createdAt: now, modifiedAt: now, latitude: 0, longitude: 0)
        jot1.write()
        let jot2 = Jot(id: 2, data: text2, queue: false, createdAt: now, modifiedAt: now, latitude: 0, longitude: 0)
        jot2.write()
        let createdAt3 = "04-20-6969 10:55:30"
        let jot3 = Jot(id: 237844, data: text3, queue: true, createdAt: createdAt3, modifiedAt: createdAt3, latitude: 20, longitude: 0)
        jot3.write()
        
        XCTAssertNotEqual(jot1, jot2)
        let readJot = Jot.read(givenID: 4)
        XCTAssertEqual(jot1, readJot)
        XCTAssertNotEqual(jot2, readJot)
        /// This test fails because of a problem in writing to the database.
        /// If given a lat or lng, it defaults to 0.
        XCTAssertEqual(jot3, Jot.read(givenID: 237844))
    }
    
    // This is a test for the update function in the class Jot
    func testUpdate() {
        let text1: String = "Scuba diving with the squad #ThatsWack"
        let text2: String = "Scuba diving with the squad #funtimes"
        let now = "now"
        let modifiedAt = "04-20-6969 10:55:30"
        var jot1 = Jot(id: 10, data: text1, queue: true, createdAt: now, modifiedAt: now, latitude: 0, longitude: 0)
        jot1.write()
        
        XCTAssertNotEqual(jot1.data, text2)
        XCTAssertEqual(jot1.data, text1)
        XCTAssertEqual(jot1.modifiedAt, now)
        jot1.data = text2
        jot1.modifiedAt = modifiedAt
        jot1.update()
        XCTAssertEqual(jot1.modifiedAt, modifiedAt)
        XCTAssertEqual(jot1.data, text2)
    }

    func testNextId() {
        // TODO: May fail until we can systematically refresh tables in tests
        XCTAssertEqual(Jot.nextId, 237848)
    }
}
