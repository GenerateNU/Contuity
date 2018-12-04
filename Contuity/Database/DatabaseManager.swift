//
//  DatabaseManager.swift
//  Contuity
//
//  Created by Anand Kumar on 10/16/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import SQLite

/// Singleton instance of our DatabaseManager, initialized at runtime.
class DatabaseManager {

    /// Get shared static instance
    static let shared = DatabaseManager()

    /// Enforce only one instance
    private init() {}

    /// read-only db connection
    private (set) var conn: Connection?

    /// Entry point to attach a connection. Enforces that only one connection
    /// can be attached during the lifecycle of the app.
    ///
    /// - Parameter conn: a Database connection
    func attachConnection(_ conn: Connection) {
        if self.conn == nil {
            self.conn = conn
        }
    }

    /// Table initializer
    func initializeTables() {
        try? Jot.createTable()
        try? Initiative.createTable()
        try? JotInitiative.createTable()
        try? FollowUp.createTable()
    }
}

#if DEBUG
// MARK: - Extension for unit testing
extension DatabaseManager {
    /// Allows us to set the connection to adequately unit test functionality
    ///
    /// - Parameter conn: an optional DB Connection
    func set(_ conn: Connection?) {
        self.conn = conn
    }
}
#endif
