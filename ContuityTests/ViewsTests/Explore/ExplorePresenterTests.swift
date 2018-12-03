//
//  ExplorePresenterTests.swift
//  ContuityTests
//
//  Created by Anthony on 10/18/18.
//  Copyright © 2018 Generate. All rights reserved.
//
import XCTest
@testable import Contuity
class ExplorePresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Delete tables here
        let tableName = "jot"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
        
        super.tearDown()
    }
    
    func testGetJots() throws {
        let jot1 = Jot(id: 2, data: "", queue: false, createdAt: "now", modifiedAt: "now", latitude: 0, longitude: 0)
        let jot2 = Jot(id: 1, data: "", queue: false, createdAt: "now", modifiedAt: "now", latitude: 0, longitude: 0)
        
        jot1.write()
        jot2.write()
        
        let expectedJots = [jot2, jot1]
        
        let sut = ExplorePresenter()
        
        XCTAssertEqual(sut.jots, expectedJots)
    }
}
