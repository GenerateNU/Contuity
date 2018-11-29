//
//  FollowUpTests.swift
//  ContuityTests
//
//  Created by Reza Akhtar on 28.11.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

import XCTest
@testable import Contuity

class FollowupTests: XCTestCase {
    
    override func setUp() {
        // Create tables
    }
    
    override func tearDown() {
        // Delete tables here
        let tableName = "followup"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
    }

    
    // This is a test for the implementation of the equatable protocol in Jot
    func testEquatable() {
        let followup1: FollowUp = FollowUp(id: 1,
                                           jotid: 1,
                                           datetime: "04-20-6969 10:55:30")
        let followup1Clone: FollowUp = FollowUp(id: 1,
                                                jotid: 1,
                                                datetime: "04-20-6969 10:55:30")
        let followup2: FollowUp = FollowUp(id: 4,
                                           jotid: 1,
                                           datetime: "04-20-6969 10:55:30")
        let followup3: FollowUp = FollowUp(id: 1,
                                           jotid: 1,
                                           datetime: "04-2-6969 10:55:30")
        XCTAssertEqual(followup1, followup1)
        XCTAssertEqual(followup1, followup1Clone)
        XCTAssertNotEqual(followup1, followup2)
        XCTAssertNotEqual(followup1, followup3)
    }
    
    // This is a test for the write function in the class Jot
    func testWrite() {
        let followup1: FollowUp = FollowUp(id: 1,
                                           jotid: 1,
                                           datetime: "04-20-6969 10:55:30")
        followup1.write()
        
        let statement = try! DatabaseManager.shared.conn?.prepare("SELECT * FROM followup")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 3)
        XCTAssertEqual(statement?.columnNames, ["id", "jotid", "datetime"])
    }
    
    // This is a test for the read function in the class Jot
    func testRead() {
        let followup1: FollowUp = FollowUp(id: 2,
                                           jotid: 5,
                                           datetime: "04-20-6969 10:55:30")
        followup1.write()
        
        let statement = try! DatabaseManager.shared.conn?.prepare("SELECT * FROM followup")
        XCTAssertNotNil(statement)
        XCTAssertEqual(statement?.columnCount, 3)
        XCTAssertEqual(statement?.columnNames, ["id", "jotid", "datetime"])
        XCTAssertEqual(FollowUp.read(givenID: 2), followup1)
    }
    
    // This is a test for the update function in the class Jot
    func testUpdate() {
    }
}
