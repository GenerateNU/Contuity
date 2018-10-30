//
//  Prettify.swift
//  Contuity
//
//  Created by Anand Kumar on 10/11/18.
//  Copyright © 2018 Generate. All rights reserved.
//

/// Separation of concerns - UI logic that is not done through Interface Builder belongs here.
/// ViewControllers should conform to this protocol and will provide all 'beautification' logic in this function.
protocol Prettify {
    /// Makes our views look great :)
    func prettify()
}
