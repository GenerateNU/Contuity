//
//  ReadJotPresenterTests.swift
//  ContuityTests
//
//  Created by Reza Akhtar on 08.11.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class ReadJotPresenterTests: XCTestCase {
    
    var sut: ReadJotPresenter!
    
    override func setUp() {
        super.setUp()
        
        sut = ReadJotPresenter()
    }
    
    override func tearDown() {
        sut = nil
        
        // Delete tables here
        let tableName = "jot"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
        
        super.tearDown()
    }
    
    func testGetJotID() {
        let jotID = 444
        let actualData = "test set jot id 444"
        let writeJot = Jot(id: jotID,
                           data: actualData,
                           queue: false,
                           createdAt: "now",
                           modifiedAt: nil,
                           latitude: nil,
                           longitude: nil)
        writeJot.write()
        XCTAssertEqual(sut.getText(jotID: jotID), actualData)
    }
}
