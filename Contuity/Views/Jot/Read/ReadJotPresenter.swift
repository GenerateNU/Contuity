//
//  ReadJotPresenter.swift
//  Contuity
//
//  Created by Reza Akhtar on 18.10.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

protocol ReadJotPresenterProtocol: PresenterProtocol {
    /// Text displayed by this ReadJot
    var text: String { get }
    
    /// This function retrieves the jot represented by the given id from the database;
    /// sets the text of this ReadJot to the retrived Jot
    mutating func setText(id: Int) -> Void
}

/// This class represents a read jot presenter
class ReadJotPresenter: ReadJotPresenterProtocol {
    var view: ReadJotViewController?
    
    var text: String = ""
    
    func setText(id: Int) {
        return self.text = "newText"
    }
    
    typealias ViewProtocolType = ReadJotViewController
}
