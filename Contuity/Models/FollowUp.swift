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
    var jotid: Int
    var text: String?
    var datetime: Date

    init(id: Int, jotid: Int, text: String?, datetime: Date){
        self.id = id
        self.jotid = jotid
        self.text = text
        self.datetime = datetime
    }
}
