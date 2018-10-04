//
//  Reminder.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class Reminder {
    
    var id: Int
    var jot_id: Int
    var type: String?
    
    init(id: Int, jot_id: Int, type: String?){
        self.id = id
        self.jot_id = jot_id
        self.type = type
    }
}
