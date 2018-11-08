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
        
        super.tearDown()
    }
    
    func testSetJotID() {
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
        XCTAssertEqual(sut.text, "")
        sut.setText(jotID: jotID)
        XCTAssertEqual(sut.text, actualData)
    }
}
