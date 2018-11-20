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
    /// returns the text to be displayed by this ReadJot
    func getText(jotID: Int) -> String
}

/// This class represents a read jot presenter
class ReadJotPresenter: ReadJotPresenterProtocol {
    weak var view: ReadJotViewController?
    func attachView(_ view: ReadJotViewController?) {
        self.view = view
    }
    /// this method returns the text at the given id.
    func getText(jotID: Int) -> String {
        guard let readJot = Jot.read(givenID: jotID) else {
            return "ERROR: could not retrieve jot."
        }
        return readJot.data
    }
}
