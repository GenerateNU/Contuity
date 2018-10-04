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
    var created_at: NSDate?
    var modified_at: NSDate?
    var longitude: Float
    var latitude: Float
    
    init(id: Int, data: String?, queue: Bool, created_at: NSDate?, modified_at: NSDate?, longitude: Float, latitude: Float){
        self.id = id
        self.data = data
        self.queue = queue
        self.created_at = created_at
        self.modified_at = modified_at
        self.longitude = longitude
        self.latitude = latitude
    }
}
