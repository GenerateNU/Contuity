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

    func testEquatable() {
        let jot1 = Jot(id: 0, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)
        let jot2 = Jot(id: 1, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)

        XCTAssertEqual(jot1, jot1)
        XCTAssertNotEqual(jot1, jot2)
    }

    func testWrite() {
        let jot1 = Jot(id: -1, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)
        jot1.write()

        let statement = try! DatabaseManager.shared.conn?.prepare("SELECT * FROM jot")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 7)
        XCTAssertEqual(statement?.columnNames, ["id", "data", "queue", "createdAt", "modifiedAt", "latitude", "longitude"])
    }
    
    func testRead() {
        let text1: String = "Whoa, I can't believe this works"
        let text2: String = "The text for jot2"
        let text3: String = "Scuba diving with the squad #funtimes"
        let now = "now"
        let jot1 = Jot(id: 1, data: text1, queue: false, createdAt: now, modifiedAt: now, latitude: 0, longitude: 0)
        jot1.write()
        let jot2 = Jot(id: 2, data: text2, queue: false, createdAt: now, modifiedAt: now, latitude: 0, longitude: 0)
        jot1.write()
        let createdAt3 = "04-20-6969 10:55:30"
        let jot3 = Jot(id: 3, data: text3, queue: true, createdAt: createdAt3, modifiedAt: createdAt3, latitude: 0, longitude: 0)
        jot3.write()
        
        XCTAssertNotEqual(jot1, jot2)
        
        /// these tests don't work yet; run them once you expect the read method to work
        let readJot = Jot.read(givenID: 1)
        XCTAssertEqual(jot1, readJot)
        XCTAssertNotEqual(jot2, readJot)
        XCTAssertEqual(jot3, Jot.read(givenID: 3))
    }
}
