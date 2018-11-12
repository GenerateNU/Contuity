//
//  ExploreTests.swift
//  ContuityTests
//
//  Created by Anthony on 10/18/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class ExplorePresenterTests: XCTestCase {
    
    func testGetJots() throws {
        var jots: [Jot] = []
        let jot1 = Jot(id: 0, data: "", queue: true, createdAt: "now", modifiedAt: "now", latitude: 0, longitude: 0)
        let jot2 = Jot(id: 1, data: "", queue: true, createdAt: "now", modifiedAt: "now", latitude: 0, longitude: 0)
        
        jot1.write()
        jot2.write()
        
        let expectedJots = [jot1, jot2]
        
        let sut = ExplorePresenter()
        
        do {
            jots = try sut.getJots()
        }
        
        XCTAssertEqual(jots, expectedJots)
    }
}
