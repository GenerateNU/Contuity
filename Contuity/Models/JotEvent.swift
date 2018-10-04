//
//  JotEvent.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class JotEvent {
    
    var jot_id: Int
    var event_id: Int
    
    init(jot_id: Int, event_id: Int){
        self.jot_id = jot_id
        self.event_id = event_id
    }
}
