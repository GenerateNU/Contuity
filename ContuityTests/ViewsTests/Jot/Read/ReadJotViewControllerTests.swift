//
//  ReadJotViewControllerTests.swift
//  ContuityTests
//
//  Created by Reza Akhtar on 24.10.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class ReadJotViewControllerTests: XCTestCase {
    
    var sut: ReadJotViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        sut = ReadJotViewController()
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
        XCTAssertEqual(sut.textView.text, "Reza is the best")
        XCTAssertEqual(sut.textView.font, .systemFont(ofSize: 22))
    }
    
    func testTapSaveButtonCallsCreateJot() {
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

private extension ReadJotViewControllerTests {
    class MockWriteJotPresenter: WriteJotPresenter {
        
        var createdJot = false
        
        override func createJot(lat: Double?, lng: Double?) {
            createdJot = true
        }
    }
}
