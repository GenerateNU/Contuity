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
    var followups: [FollowUp] { get }
    func chronologizeFollowups()
}

class TodayPresenter: TodayPresenterProtocol {
    var followups: [FollowUp] { return FollowUp.getAll() }
    weak var view: TodayViewProtocol?
    
    func attachView(_ view: TodayViewProtocol?) {
        self.view = view
    }
    
    /// orders the followups in chronological order so they can be displayed.
    func  chronologizeFollowups() {
        var orderedFollowups: [FollowUp] = []
        for followup in followups {
            guard let date = Date.date(from: followup.datetime) else {
                continue
            }
            orderedFollowups.insert(followup, at: TodayPresenter.findPosition(date: date,
                                                                              currentFollowups: orderedFollowups))
        }
    }
    
    /// Helper for the method chronologizeFollowups
    private static func findPosition(date: Date, currentFollowups: [FollowUp]) -> Int {
        for index in 0...currentFollowups.count {
            guard let secondDate = Date.date(from: currentFollowups[index].datetime) else {
                continue
            }
            if date.compare(secondDate) == .orderedAscending {
                return index
            }
        }
        return 0
    }
}
