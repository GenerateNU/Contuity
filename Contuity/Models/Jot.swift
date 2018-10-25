//
//  File.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

class Jot {
    
    var id: Int
    var data: String?
    var queue: Bool
    var createdat: Date
    var modifiedat: Date?
    var longitude: Double?
    var latitude: Double?
    
    init(id: Int, data: String?, queue: Bool, createdat: Date, modifiedat: Date?, longitude: Double?, latitude: Double?){
        self.id = id
        self.data = data
        self.queue = queue
        self.createdat = createdat
        self.modifiedat = modifiedat
        self.longitude = longitude
        self.latitude = latitude
    }
}
