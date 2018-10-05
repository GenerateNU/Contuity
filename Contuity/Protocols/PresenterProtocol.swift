//
//  PresenterProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

protocol PresenterProtocol {

    var view: ViewProtocol? { get set }

    mutating func attachView(_ view: ViewProtocol?)
}

extension PresenterProtocol {
    mutating func attachView(_ view: ViewProtocol?) {
        self.view = view
    }
}
