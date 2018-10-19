//
//  DatabaseManagerTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/17/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
import SQLite
@testable import Contuity

class DatabaseManagerTests: XCTestCase {

    func testConnectionIsNotNil() {
        XCTAssertNotNil(DatabaseManager.shared.conn)
    }

    func testAttachConnectionSetsSharedConnection() {
        let current = DatabaseManager.shared.conn!

        DatabaseManager.shared.set(nil)

        XCTAssertNil(DatabaseManager.shared.conn)

        DatabaseManager.shared.attachConnection(current)

        XCTAssertNotNil(DatabaseManager.shared.conn)
    }

}
