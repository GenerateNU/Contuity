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
    func getJots() -> [Jot]
}

class ExplorePresenter: ExplorePresenterProtocol {
    var jots: [Jot] = []
    
    weak var view: ExploreViewProtocol?
    
    func attachView(_ view: ExploreViewProtocol?) {
        self.view = view
    }
    
    func getJots() -> [Jot] {
        var jots: [Jot] = []
        let jot = Jot(id: 0,
                            data: "text",
                            queue: true,
                            createdAt: Date().timestamp(),
                            modifiedAt: nil,
                            latitude: 0.0,
                            longitude: 0.0)
        jots.append(jot)
        return jots
    }
}
