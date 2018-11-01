//
//  WriteJotPresenter.swift
//  Contuity
//
//  Created by Anand Kumar on 10/10/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import UIKit

protocol WriteJotPresenterProtocol: PresenterProtocol {
    /// Text body that needs to be saved as the Jot
    var text: String { get set }

    /// Creates a Jot using the text and writes to the database
    ///
    /// - Parameters:
    ///   - lat: Optional double representing the latitude.
    ///   - lng: Optional double representing the longitude.
    func createJot(lat: Double?, lng: Double?)
}

class WriteJotPresenter: WriteJotPresenterProtocol {
    var text: String = ""

    var view: WriteJotViewProtocol?

    func attachView(_ view: WriteJotViewProtocol?) {
        self.view = view
    }

    func createJot(lat: Double? = nil, lng: Double? = nil) {
        let jot =  Jot(id: Int.random(in: 0...1000000),
                   data: text,
                   queue: shouldQueue(),
                   createdAt: Date().timestamp(),
                   modifiedAt: nil,
                   latitude: lat,
                   longitude: lng)

        jot.write()
    }

    /// Helper function to determine whether this Jot should be added to the queue.
    ///
    /// TODO: Write queueing logic
    ///
    /// - Returns: True if it should be in the queue.
    private func shouldQueue() -> Bool {
        return true
    }
}
