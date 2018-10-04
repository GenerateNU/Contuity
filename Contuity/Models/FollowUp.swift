//
//  FollowUp.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class FollowUp {
    
    var id: Int
    var jot_id: Int
    var text: String?
    var datetime: NSDate?
    
    init(id: Int, jot_id: Int, text: String?, datetime: NSDate?){
        self.id = id
        self.jot_id = jot_id
        self.text = text
        self.datetime = datetime
    }
}
