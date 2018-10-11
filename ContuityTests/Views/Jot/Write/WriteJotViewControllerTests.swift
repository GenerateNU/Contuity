//
//  WriteJotViewControllerTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/11/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class WriteJotViewControllerTests: XCTestCase {

    var sut: WriteJotViewController!
    var navigationController: UINavigationController!

    override func setUp() {
        super.setUp()

        sut = WriteJotViewController()
        navigationController = UINavigationController(rootViewController: sut)

        _ = sut.view
    }

    func testPresenterIsAttached() {
        XCTAssertTrue(sut.presenter.view === sut)
    }

    func testBeautify() {
        XCTAssertFalse(sut.textView.isHidden)
        XCTAssertTrue(sut.textView.isEditable)
    }
}
