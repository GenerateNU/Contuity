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

    /// Creates a Jot using the text and writes to the database.
    /// The text is then parsed and initiatives are written.
    ///
    /// - Parameters:
    ///   - id: Optional int id, otherwise randomly picks one
    ///   - lat: Optional double representing the latitude.
    ///   - lng: Optional double representing the longitude.
    func createData(at id: Int, lat: Double?, lng: Double?)
}

class WriteJotPresenter: WriteJotPresenterProtocol {

    var text: String = ""

    var view: WriteJotViewProtocol?

    func attachView(_ view: WriteJotViewProtocol?) {
        self.view = view
    }

    func createData(at id: Int = Int.random(in: 0...1000000), lat: Double? = nil, lng: Double? = nil) {
        let jot =  Jot(id: id,
                   data: text,
                   queue: shouldQueue(),
                   createdAt: Date().timestamp(),
                   modifiedAt: nil,
                   latitude: lat,
                   longitude: lng)

        jot.write()

        createInitiatives(with: jot.id)
    }

    private func createInitiatives(with jotId: Int) {
        let initiatives: [Initiative] = text.taggedWords.map { value -> Initiative in
            return Initiative(name: value, parent: nil)
        }

        initiatives.forEach { initiative in
            initiative.write()

            let bridge = JotInitiative(jotId: jotId, initiativeTag: initiative.name)
            bridge.write()
        }
    }

    /// Helper function to determine whether this Jot should be added to the queue.
    ///
    ///
    /// - Returns: True if it should be in the queue.
    private func shouldQueue() -> Bool {
        return text.taggedWords.count <= 0
    }
}
