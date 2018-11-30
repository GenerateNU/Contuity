//
//  ExploreViewControllerTests.swift
//  ContuityTests
//
//  Created by Anthony on 11/25/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity


class ExploreViewControllerTests: XCTestCase {

    var sut: ExploreViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        sut = ExploreViewController()
        let jotID = 502
        let writeJot = Jot(id: jotID,
                           data: "hello",
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
        super.tearDown()
        
        sut = nil
        
        // Delete tables here
        let tableName = "jot"
        try? DatabaseManager.shared.conn?.execute("DELETE FROM " + tableName)
    }
    
    func testViewDidLoad() {
        XCTAssertTrue(sut.presenter.view === sut)
    }
    
    func testTableViewCount() {
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 1), 1)
    }
    
    func testTableViewCell() {
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "hello")
    }
}
