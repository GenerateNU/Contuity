//
//  DatabaseInitializationProtocol.swift
//  Contuity
//
//  Created by Anand Kumar on 10/13/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import SQLite

protocol DatabaseInitializationProtocol {
    static func createTable(conn: Connection) throws
}
