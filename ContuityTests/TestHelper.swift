//
//  TestHelper.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/11/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

extension XCTestCase {
    /// Returns a fixed date with no time zone: 05 31, 2018 12:30:15
    var fixedDate: Date
    {
        var dateComponents = DateComponents()
        dateComponents.month = 5
        dateComponents.day = 31
        dateComponents.year = 2018
        dateComponents.hour = 12
        dateComponents.minute = 30
        dateComponents.second = 15
        dateComponents.calendar = .current

        return dateComponents.date!
    }
}
