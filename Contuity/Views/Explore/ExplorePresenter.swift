//
//  ExplorePresenter.swift
//  Contuity
//
//  Created by Anthony on 10/18/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

protocol ExplorePresenterProtocol: PresenterProtocol {
    /// The jots that need to be displayed
    var jots: [Jot] { get set }
    
    /// Gets all the Jots to show on the Explore page
    ///
    /// - Returns: a list of Jots to display
    /// - Throws: DatabaseError.selectFailed if the SELECT operation on the database failed
    func getJots() throws -> [Jot]
}

class ExplorePresenter: ExplorePresenterProtocol {
    var jots: [Jot] = []
    
    weak var view: ExploreViewProtocol?
    
    func attachView(_ view: ExploreViewProtocol?) {
        self.view = view
    }
    
    func getJots() throws -> [Jot] {
        do {
            return try Jot.getJots(queue: false)
        }
    }
}
