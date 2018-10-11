//
//  PresenterProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

protocol PresenterProtocol {

    associatedtype ViewProtocolType

    var view: ViewProtocolType? { get set }

    mutating func attachView(_ view: ViewProtocolType?)
}

extension PresenterProtocol {
    mutating func attachView(_ view: ViewProtocolType?) {
        self.view = view
    }
}
