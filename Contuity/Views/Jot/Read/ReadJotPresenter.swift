//
//  ReadJotPresenter.swift
//  Contuity
//
//  Created by Reza Akhtar on 18.10.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

/// This protocol represents the protocol for a read jot presenter
protocol ReadJotPresenterProtocol: PresenterProtocol {
    /// Text displayed by this ReadJot
    var text: String { get }
    /// This function retrieves the jot represented by the given id from the database;
    /// sets the text of this ReadJot to the retrived Jot
    mutating func setText(jotID: Int)
}

/// This class represents a read jot presenter
class ReadJotPresenter: ReadJotPresenterProtocol {
    var text: String = ""
    weak var view: ReadJotViewController?
    func attachView(_ view: ReadJotViewController?) {
        self.view = view
    }
    func setText(jotID: Int) {
        guard let readJot = Jot.read(givenID: jotID) else {
            // TODO: make this throw an exception
            // could not retrieve
            self.text = "ERROR: could not retrieve jot."
            return
        }
        self.text = readJot.data
    }
}
