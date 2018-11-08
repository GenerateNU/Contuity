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

    var update: Bool { get set }
    
    var jotID: Int { get set }
    
    /// Creates a Jot using the text and writes to the database
    ///
    /// - Parameters:
    ///   - lat: Optional double representing the latitude.
    ///   - lng: Optional double representing the longitude.
    func saveJot(lat: Double?, lng: Double?)
    func setJotID(givenID: Int)
}

class WriteJotPresenter: WriteJotPresenterProtocol {
    /// id shouldn't be random...
    var text: String = ""
    var update: Bool = false
    var jotID: Int = Int.random(in: 0...1000000)

    weak var view: WriteJotViewProtocol?

    func attachView(_ view: WriteJotViewProtocol?) {
        self.view = view
    }

    func saveJot(lat: Double? = nil, lng: Double? = nil) {
        if update {
            guard let updateJot = Jot.read(givenID: self.jotID) else {
                return
            }
            updateJot.update()
        }
        else {
            /// TODO: fix al random id assignments
            self.jotID = Int.random(in: 0...1000000)
            let jot =  Jot(id: jotID,
                           data: text,
                           queue: shouldQueue(),
                           createdAt: Date().timestamp(),
                           modifiedAt: nil,
                           latitude: lat,
                           longitude: lng)
            jot.write()
        }
    }
    func setJotID(givenID: Int) {
        self.jotID = givenID
        self.text = Jot.read(givenID: jotID)?.data ?? ""
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
