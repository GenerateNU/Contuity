//
//  Event.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class Event {
    
    var id: Int
    var name: String?
    var latitude: Float
    var longitude: Float
    var created_at: NSDate?
    var event_time: NSDate?
    
    init(id: Int, name: String?, latitude: Float, longitude: Float, created_at: NSDate?, event_time: NSDate?){
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.created_at = created_at
        self.event_time = event_time
    }
}
