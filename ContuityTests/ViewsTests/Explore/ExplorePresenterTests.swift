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
    
    func testGetJots() throws {
        let jot1 = Jot(id: 0, data: "", queue: true, createdAt: "now", modifiedAt: "now", latitude: 0, longitude: 0)
        let jot2 = Jot(id: 1, data: "", queue: true, createdAt: "now", modifiedAt: "now", latitude: 0, longitude: 0)
        
        jot1.write()
        jot2.write()
        
        let expectedJots = [jot1, jot2]
        
        let sut = ExplorePresenter()
        
        XCTAssertEqual(sut.jots, expectedJots)
    }
    
    func testFilter() {
        let jot = Jot(id: 0, data: "hi", queue: true, createdAt: "", modifiedAt: "", latitude: nil, longitude: nil)
        let ji = JotInitiative(jotId: 0, initiativeTag: "ayyy")
        let jot1 = Jot(id: 1, data: "bye", queue: true, createdAt: "", modifiedAt: "", latitude: nil, longitude: nil)
        let ji1 = JotInitiative(jotId: 0, initiativeTag: "ayyy")
        let jot2 = Jot(id: 0, data: "hi", queue: true, createdAt: "", modifiedAt: "", latitude: nil, longitude: nil)
        let ji2 = JotInitiative(jotId: 0, initiativeTag: "asdf")
        jot.write()
        jot1.write()
        jot2.write()
        ji.write()
        ji1.write()
        ji2.write()
        let ayyy = [jot, jot1]
        let asdf = [jot2]
        
        let sut = ExplorePresenter()
        
        XCTAssertEqual(sut.filter(initiative: "ayyy"), ayyy)
        XCTAssertEqual(sut.filter(initiative: "asdf"), asdf)
    }
}
