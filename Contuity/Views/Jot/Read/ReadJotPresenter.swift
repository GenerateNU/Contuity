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
        let readJot = Jot.read(givenID: jotID)
        if readJot == nil {
            self.text = "ERROR: could not retrieve Jot"
        }
        else if readJot!.data == nil {
            self.text = "[no text to display]"
        }
        else {
            self.text = readJot!.data!
        }
    }
    typealias ViewProtocolType = ReadJotViewController
}
