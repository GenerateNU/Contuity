//
//  ExploreTests.swift
//  ContuityTests
//
//  Created by Anthony on 10/18/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class ExploreTests: XCTestCase {

    func testGetJots() {
        let jot1 = Jot(id: 0, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)
        let jot2 = Jot(id: 1, data: "", queue: true, createdAt: "now", modifiedAt: nil, latitude: nil, longitude: nil)
        
        jot1.write()
        jot2.write()
        
        
    }

}
