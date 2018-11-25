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
}

class ExplorePresenter: ExplorePresenterProtocol {
    var jots: [Jot] = []
    init() {
        print("hi")
        do {
            jots = try Jot.getJots(queue: false)
            print(jots)
        }
        catch {
            print("bye")
        }
    }
    weak var view: ExploreViewProtocol?
    func attachView(_ view: ExploreViewProtocol?) {
        self.view = view
    }
}
