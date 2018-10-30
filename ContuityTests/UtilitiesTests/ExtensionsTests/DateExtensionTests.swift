//
//  DateExtensionTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/17/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class DateExtensionTests: XCTestCase {

    func testToTimestampConversion() {
        XCTAssertEqual(fixedDate.timestamp(), "05-31-2018 12:30:15")
    }

    func testFromTimestampConversion() {
        XCTAssertEqual(Date.date(from: "05-31-2018 12:30:15"), fixedDate)
    }
}
