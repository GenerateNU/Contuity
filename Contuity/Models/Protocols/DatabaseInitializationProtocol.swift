//
//  DatabaseInitializationProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/13/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import SQLite

/**
 Protocol specification for database initialization.

 Currently supports creating new tables via connections.
 */
protocol DatabaseInitializationProtocol {
    /// Creates a database table for a model.
    ///
    /// - Throws: DatabaseError on table initialization failure
    static func createTable() throws
}

class DatabaseManager {

    static let shared = DatabaseManager()

    private init() {}

    var conn: Connection?

    func attachConnection(_ conn: Connection) {
        if self.conn == nil {
            self.conn = conn
        }
    }

    func initializeTables() {
        try? Jot.createTable()
    }
}
