//
//  WriteJotPresenterTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/11/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class WriteJotPresenterTests: XCTestCase {

    var sut: WriteJotPresenter!

    override func setUp() {
        super.setUp()

        sut = WriteJotPresenter()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testCreateDataAddsInitiativesToDatabaseProperly() {
        sut.text = "yoooo #imthebest"

        sut.createData(at: 999999)

        let bridgeStmt = try! DatabaseManager.shared.conn?.prepare(
            "SELECT * FROM jotInitiative where jotId = 999999")
        XCTAssertNotNil(bridgeStmt)
        XCTAssertEqual(bridgeStmt?.columnCount, 2)

        let initiativeStmt = try! DatabaseManager.shared.conn?.prepare(
            "SELECT * FROM initiative where name = #imthebest")
        XCTAssertNotNil(initiativeStmt)
        XCTAssertEqual(initiativeStmt?.columnCount, 2)
    }
}
