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
    var created_at: NSDate?
    
    init(id: Int, name: String?, number: String?, email: String?, created_at: NSDate?){
        self.id = id
        self.name = name
        self.number = number
        self.email = email
        self.created_at = created_at
    }
}
