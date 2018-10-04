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
    var latitude: Double?
    var longitude: Double?
    var createdat: Date
    var eventtime: Date?
    
    init(id: Int, name: String?, latitude: Double?, longitude: Double?, createdat: Date, eventtime: Date?){
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.createdat = createdat
        self.eventtime = eventtime
    }
}
