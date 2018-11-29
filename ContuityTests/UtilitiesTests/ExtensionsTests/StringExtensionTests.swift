//
//  StringExtensionTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 11/1/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class StringExtensionTests: XCTestCase {

    func testTaggedWordsPatternMatch() {
        XCTAssertEqual("ayyy lmao".taggedWords, [])
        XCTAssertEqual("ayyy lmao #itslit".taggedWords, ["#itslit"])
        XCTAssertEqual("#".taggedWords, [])
        XCTAssertEqual("".taggedWords, [])
        XCTAssertEqual("Smitty Werberjagermanjensen ... he was #1".taggedWords, [])
        XCTAssertEqual("#scuba #diving #aesthet1c".taggedWords, ["#scuba", "#diving", "#aesthet1c"])
        XCTAssertEqual("#420blazeit yo generate is lit!!1!11! #generate".taggedWords, ["#420blazeit", "#generate"])
    }
}
