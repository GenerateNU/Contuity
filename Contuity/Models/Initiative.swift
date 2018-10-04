//
//  Initiative.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class Initiative {
    
    var id: Int
    var jotid: Int
    var name: String
    var parent: Int // if parentid == id, top level initiative
    
    init(id: Int, jotid: Int, name: String, parent: Int){
        self.id = id
        self.jotid = jotid
        self.name = name
        self.parent = parent
    }
}
