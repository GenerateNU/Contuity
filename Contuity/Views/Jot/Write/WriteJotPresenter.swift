//
//  WriteJotPresenter.swift
//  Contuity
//
//  Created by Anand Kumar on 10/10/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import UIKit

protocol WriteJotPresenterProtocol: PresenterProtocol {
    var text: String { get set }

    func createJot(lat: Double?, lng: Double?) -> Jot
}

class WriteJotPresenter: WriteJotPresenterProtocol {
    var text = ""

    weak var view: WriteJotViewProtocol?

    func attachView(_ view: WriteJotViewProtocol?) {
        self.view = view
    }

    func createJot(lat: Double? = nil, lng: Double? = nil) -> Jot {
        return Jot(id: 0,
                   data: text,
                   queue: shouldQueue(),
                   createdAt: Date().timestamp(),
                   modifiedAt: nil,
                   latitude: lat,
                   longitude: lng)
    }

    private func shouldQueue() -> Bool {
        return true
    }
}
