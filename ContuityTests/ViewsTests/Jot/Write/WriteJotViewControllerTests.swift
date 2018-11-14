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

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func testViewDidLoad() {
        XCTAssertTrue(sut.presenter.view === sut)
        XCTAssertNotNil(sut.textView.delegate)
        XCTAssertTrue(sut.textView.delegate === sut)
    }

    func testBeautify() {
        XCTAssertEqual(sut.saveButton.title(for: .normal), "Save!")

        XCTAssertFalse(sut.textView.isHidden)
        XCTAssertTrue(sut.textView.isEditable)
        XCTAssertEqual(sut.textView.text, "")
        XCTAssertEqual(sut.textView.font, .systemFont(ofSize: 22))
    }

    func testTapSaveButtonCallsCreateData() {
        let mockPresenter = MockWriteJotPresenter()
        sut.presenter = mockPresenter

        XCTAssertFalse(mockPresenter.createdJot)

        sut.saveButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(mockPresenter.createdJot)
    }

    func testWriteInViewUpdatesPresenterText() {
        sut.textView.text = "ayyyy lmao"
        XCTAssertEqual(sut.presenter.text, "")
        sut.textViewDidChange(sut.textView)

        XCTAssertEqual(sut.presenter.text, "ayyyy lmao")
    }
}

private extension WriteJotViewControllerTests {
    class MockWriteJotPresenter: WriteJotPresenter {

        var createdJot = false

        override func saveJot(lat: Double?, lng: Double?) {
            createdJot = true
        }
    }
}
