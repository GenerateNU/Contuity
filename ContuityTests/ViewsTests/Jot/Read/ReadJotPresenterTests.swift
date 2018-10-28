//
//  ReadJotPresenterTests.swift
//  ContuityTests
//
//  Created by Reza Akhtar on 24.10.18.
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
}
