//
//  ViewProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

///  A protocol for all views to adhere to. This is necessary to fit into MVP.
protocol ViewProtocol {
    associatedtype PresenterType: PresenterProtocol

    /// The presenter who is responsible to update the view.
    var presenter: PresenterType {get set}
}
