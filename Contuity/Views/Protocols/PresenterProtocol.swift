//
//  PresenterProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

/// Base presenter protocol specification ensures each Presenter will have an associated View.
protocol PresenterProtocol {

    /// An associated type to internally represent the [ViewProtocol](ViewProtocol.html)
    associatedtype ViewProtocolType

    var view: ViewProtocolType? { get set }

    /// A function for attaching a view to this Presenter
    ///
    /// - Parameter view: a view controller conforming to the ViewProtocol
    mutating func attachView(_ view: ViewProtocolType?)
}

extension PresenterProtocol {
    mutating func attachView(_ view: ViewProtocolType?) {
        self.view = view
    }
}
