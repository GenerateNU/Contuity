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
}
