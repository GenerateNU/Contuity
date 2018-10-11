//
//  ViewProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

protocol ViewProtocol {
    associatedtype PresenterType: PresenterProtocol

    var presenter: PresenterType {get set}
}
