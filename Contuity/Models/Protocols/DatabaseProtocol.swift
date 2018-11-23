//
//  DatabaseProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/13/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

/**
 Protocol specification for database initialization.

 Currently supports creating new tables via connections.
*/
protocol DatabaseProtocol {
    /// Creates a database table for a model.
    ///
    /// - Throws: DatabaseError on table initialization failure
    static func createTable() throws

    /// Writes a model to the database. Generally called from presenters.
    func write()
    /// Updates the model to the database.
    func update()
}
