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

    /// If true, then this WriteJotPresenter is updating an existing jot
    var update: Bool { get set }

    /// The id of the jot being written or updated
    var jotID: Int { get set }

    /// A list which contains all the followups attached to this jot.
    var followupDates: [Date] { get set }

    /// Creates a Jot using the text and writes to the database.
    ///
    /// - Parameters:
    ///   - lat: Optional double representing the latitude.
    ///   - lng: Optional double representing the longitude.
    func saveJot(lat: Double?, lng: Double?)

    /// Sets the id of this presenter to the given id
    ///
    /// - Parameters:
    ///   - givenID: the id that this id should be set to
    func setJotID(givenID: Int)
}

class WriteJotPresenter: WriteJotPresenterProtocol {
    var text: String = ""
    var update: Bool = false
    var jotID: Int = Int.random(in: 0...1000000)
    var followupDates: [Date] = []

    var view: WriteJotViewProtocol?

    func attachView(_ view: WriteJotViewProtocol?) {
        self.view = view
    }

    func saveJot(lat: Double? = nil, lng: Double? = nil) {
        if update {
            do {
                let updateJot = try Jot.read(givenID: self.jotID)
                updateJot.update()
            }
            catch {
                return
            }
        }
        else {
            self.jotID = Jot.nextId
            let jot =  Jot(id: jotID,
                           data: text,
                           queue: shouldQueue(),
                           createdAt: Date().timestamp(),
                           modifiedAt: nil,
                           latitude: lat,
                           longitude: lng)
            jot.write()
        }

        createFollowups(with: self.jotID)
        createInitiatives(with: self.jotID)
    }

    private func createFollowups(with jotId: Int) {
        for date in followupDates {
            let followup = FollowUp(id: FollowUp.nextId,
                                    jotid: self.jotID,
                                    datetime: date.timestamp())
            followup.write()
        }
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

    /// This method sets the id of the given jot.
    func setJotID(givenID: Int) {
        self.jotID = givenID
        do {
            self.text = try Jot.read(givenID: jotID).data
        }
        catch {
            self.text = ""
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
