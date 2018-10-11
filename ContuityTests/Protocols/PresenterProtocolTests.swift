//
//  PresenterProtocolTests.swift
//  ContuityTests
//
//  Created by Anand Kumar on 10/11/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import XCTest
@testable import Contuity

class PresenterProtocolTests: XCTestCase {
    func testAttachView() {
        let mockView = MockView()
        mockView.presenter.attachView(mockView)
        XCTAssertEqual(mockView.presenter.view, mockView)
    }

    fileprivate class MockPresenter: PresenterProtocol {
        // swiftlint:disable nesting
        typealias ViewProtocolType = MockView
        // swiftlint:enable nesting
        fileprivate var view: MockView?
    }

    fileprivate class MockView: NSObject {
        var presenter = MockPresenter()
    }
}
