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

    func testWrite() throws {
        let jot1 = Jot(id: -1, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)
        jot1.write()

        let statement = try DatabaseManager.shared.conn?.prepare("SELECT * FROM jot")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 7)
        XCTAssertEqual(statement?.columnNames, ["id", "data", "queue", "createdAt", "modifiedAt", "latitude", "longitude"])
    }
}
