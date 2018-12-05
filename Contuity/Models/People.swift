//
//  People.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class People {

    var id: Int
    var name: String?
    var number: String?
    var email: String?
    var createdat: Date

    init(id: Int, name: String?, number: String?, email: String?, createdat: Date){
        self.id = id
        self.name = name
        self.number = number
        self.email = email
        self.createdat = createdat
    }
}
