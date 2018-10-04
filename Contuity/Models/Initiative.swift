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
    var jot_id: Int
    var name: String?
    var parent: Int
    
    init(id: Int, jot_id: Int, name: String?, parent: Int){
        self.id = id
        self.jot_id = jot_id
        self.name = name
        self.parent = parent
    }
}
