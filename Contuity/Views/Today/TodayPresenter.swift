//
//  TodayPresenter.swift
//  Contuity
//
//  Created by Reza Akhtar on 02.12.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

protocol TodayPresenterProtocol: PresenterProtocol {
    /// The followups that need to be displayed
    var followups: [FollowUp] { get set }
    func chronologizeFollowups()
}

class TodayPresenter: TodayPresenterProtocol {
    var followups: [FollowUp] = FollowUp.getAll()
    weak var view: TodayViewProtocol?
    
    func attachView(_ view: TodayViewProtocol?) {
        self.view = view
    }
    
    /// orders the followups in chronological order so they can be displayed.
    func  chronologizeFollowups() {
        var ordered: [FollowUp] {
            return followups.sorted {
                $0.datetime > $1.datetime
            }
        }
        followups = ordered
    }
}
