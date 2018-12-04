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
}

class TodayPresenter: TodayPresenterProtocol {
    var followups: [FollowUp] {
        return FollowUp.getAll().sorted {
            $0.datetime > $1.datetime
        }
    }
    weak var view: TodayViewProtocol?

    func attachView(_ view: TodayViewProtocol?) {
        self.view = view
    }
}
