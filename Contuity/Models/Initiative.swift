//
//  Initiative.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

struct Initiative {
    let name: String
    var parent: String? // if parent is null, top-level initiative
}

private extension Initiative {
    var insert: String {
        return "INSERT INTO initative (name, parent)"
    }

    var values: String {
        return "VALUES (\(name), \"\(parent ?? "NULL")\")"
    }
}

extension Initiative: Equatable {
    static func == (lhs: Initiative, rhs: Initiative) -> Bool {
        return lhs.name == rhs.name && lhs.parent == rhs.parent
    }
}

extension Initiative: DatabaseProtocol {

    static func createTable() throws {
        let table = Table("initiative")
        let name = Expression<Int>("name")
        let parent = Expression<String>("parent")

        do {
            try DatabaseManager.shared.conn?.run(
                table.create { t in
                    t.column(name, primaryKey: true)
                    t.column(parent)
            })
        } catch let Result.error(_, code, _) where code == SQLITE_CONSTRAINT {
            throw DatabaseError.constraintFailed
        } catch {
            throw DatabaseError.insertionFailed
        }
    }

    func write() {
        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare("\(insert) \(values)") else {
                return
        }
        _ = try? statement.run()
    }
    
    func update() {
        /// TODO: implement update method for Initiative
    }
}

extension Initiative {

    private static func parseRow(row: Statement.Element) throws -> Initiative {
        guard let name = row[0] as? String else {
            throw DatabaseError.selectFailed
        }
        guard let parent = row[1] as? String? else {
            throw DatabaseError.selectFailed
        }
        return Initiative(name: name, parent: parent)
    }

    static func getInitiatives() throws -> [Initiative] {
        var initiatives: [Initiative] = []
        guard let conn = DatabaseManager.shared.conn
            else {
                throw DatabaseError.selectFailed
        }
        do {
            for row in try conn.prepare("SELECT * FROM jot-initiative") {
                try initiatives.append(parseRow(row: row))
            }
        }
        catch {
            throw DatabaseError.selectFailed
        }
        throw DatabaseError.selectFailed
    }
}
