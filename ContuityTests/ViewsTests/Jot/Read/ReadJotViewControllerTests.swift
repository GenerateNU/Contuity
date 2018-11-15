//
//  ReadJotViewControllerTests.swift
//  ContuityTests
//
//  Created by Reza Akhtar on 08.11.18.
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
        sut.jotID = 502
        let writeJot = Jot(id: sut.jotID,
                           data: "",
                           queue: false,
                           createdAt: "now",
                           modifiedAt: nil,
                           latitude: nil,
                           longitude: nil)
        writeJot.write()
        navigationController = UINavigationController(rootViewController: sut)
        
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testViewDidLoad() {
        XCTAssertTrue(sut.presenter.view === sut)
    }
    
    func testBeautify() {
        XCTAssertEqual(sut.editButton.title(for: .normal), "Edit")
        XCTAssertEqual(sut.backButton.title(for: .normal), "Back")
        
        XCTAssertFalse(sut.readJotTextView.isHidden)
        XCTAssertFalse(sut.readJotTextView.isEditable)
        XCTAssertEqual(sut.readJotTextView.text, "")
        XCTAssertEqual(sut.readJotTextView.font, .systemFont(ofSize: 22))
    }
}
