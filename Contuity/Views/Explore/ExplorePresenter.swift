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
    var jots: [Jot] { get }

    func filter(initiative: String) -> [Jot]
}

class ExplorePresenter: ExplorePresenterProtocol {
    var jots: [Jot] { return (try? Jot.getJots(queue: false)) ?? [] }
    weak var view: ExploreViewProtocol?

    func attachView(_ view: ExploreViewProtocol?) {
        self.view = view
    }

    func filter(initiative: String) -> [Jot] {
        return JotInitiative.getJots(initiative: initiative)
    }
}
