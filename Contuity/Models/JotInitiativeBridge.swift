//
//  JotInitiativeBridge.swift
//  Contuity
//
//  Created by Anand Kumar on 10/29/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

struct JotInitiative {
    let jotId: Int
    let initiativeTag: String
}

private extension JotInitiative {
    var insert: String {
        return "INSERT INTO jot-initiative (jotId, initiativeId)"
    }

    var values: String {
        return "VALUES (\(jotId), \"\(initiativeTag)\")"
    }
}

extension JotInitiative: Equatable {
    static func == (lhs: JotInitiative, rhs: JotInitiative) -> Bool {
        return lhs.jotId == rhs.jotId && lhs.initiativeTag == rhs.initiativeTag
    }
}

extension JotInitiative: DatabaseProtocol {
    static func createTable() throws {
        let table = Table("jotInitiative")
        let jot = Expression<Int>("jotId")
        let initiative = Expression<String>("initiativeId")

        do {
            try DatabaseManager.shared.conn?.run(
                table.create { t in
                    t.column(jot, primaryKey: true)
                    t.column(initiative, primaryKey: true)
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
        /// TODO: implement update method for JotInitiative
    }
}

extension JotInitiative {
    static func read(givenID: Int) -> JotInitiative? {
        /// TODO: implement read method for JotInitiative
        return nil
    }

    static func getJots(initiative: String) throws -> [Jot]  {
        var jots: [Jot] = []
        guard let conn = DatabaseManager.shared.conn
            else {
                throw DatabaseError.selectFailed
        }
        do {
            for row in try conn.prepare("SELECT * FROM jot-initiative WHERE intiative = \(initiative)") {
                guard let optionalID: Int64 = row[0] as? Int64 else {
                    break
                }
                let jot = try Jot.read(givenID: Int(optionalID))
                jots.append(jot)
            }
        }
        catch {
            throw DatabaseError.selectFailed
        }
        throw DatabaseError.selectFailed
    }
}
