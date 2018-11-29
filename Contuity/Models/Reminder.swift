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
    var jotid: Int
    var type: String?

    init(id: Int, jotid: Int, type: String?){
        self.id = id
        self.jotid = jotid
        self.type = type
    }
}
