//
//  FollowUp.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

/// This class represents the followup attribute for a jot. It keeps the id of the jot to which it is attributed.
struct FollowUp {
    let id: Int
    let jotid: Int
    let datetime: String
}

extension FollowUp: Equatable {
    static func == (lhs: FollowUp, rhs: FollowUp) -> Bool {
        return lhs.id == rhs.id &&
            lhs.jotid == rhs.jotid &&
            lhs.datetime == rhs.datetime
    }
}

extension FollowUp: DatabaseProtocol {
    static func createTable() throws {
        let table = Table("followup")
        let id = Expression<Int>("id")
        let jotid = Expression<Int>("jotid")
        let datetime = Expression<String>("datetime")
        
        do {
            try DatabaseManager.shared.conn?.run(
                table.create { t in
                    t.column(id, primaryKey: true)
                    t.column(jotid)
                    t.column(datetime)
            })
        } catch let Result.error(_, code, _) where code == SQLITE_CONSTRAINT {
            throw DatabaseError.constraintFailed
        } catch {
            throw DatabaseError.insertionFailed
        }
    }

    func write() {
        let insert = "INSERT INTO followup (id, jotid, datetime)"
        let values = "VALUES (\(id), \(jotid), \"\(datetime)\")"

        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare("\(insert) \(values)") else {
                return
        }
        _ = try? statement.run()
    }

    func update() {
        // This function updates the given followup.
        func update() {
            let setMessage = "\(id), \(jotid), \(datetime)"
            let update = "UPDATE followup SET \(setMessage) WHERE id = \(id)"

            guard let conn = DatabaseManager.shared.conn,
                let statement = try? conn.prepare(update) else {
                    return
            }
            _ = try? statement.run()
        }
    }
}

extension FollowUp {
    /// TODO: throws not nil
    static func read(givenID: Int) -> FollowUp? {
        let result = retrieve(statement: "SELECT * FROM followup WHERE id = \(givenID)")
        if result.isEmpty {
            return nil
        }
        else {
            return result[0]
        }
    }
    
    /// This method returns a list of followups with the given jotid.
    static func readAll(givenJotID: Int) -> [FollowUp] {
        return retrieve(statement: "SELECT * FROM followup WHERE jotid = \(givenJotID)")
    }
    
    /// This method returns a list of all followups that exist in the data base.
    static func getAll() -> [FollowUp] {
        return retrieve(statement: "SELECT * FROM followup")
    }
    
    /// Helper function for retrieving a list of followups given a statement.
    private static func retrieve(statement: String) -> [FollowUp]{
        var result: [FollowUp] = []
        guard let conn = DatabaseManager.shared.conn
            else {
                return result
        }
        do {
            for row in try conn.prepare(statement) {
                guard let optionalID: Int64 = row[0] as? Int64,
                    let optionalJotID: Int64  = row[1] as? Int64,
                    let curDatetime = row[2] as? String else {
                        break
                }
                let curID = Int(optionalID)
                let curJotID = Int(optionalJotID)
                let currentFollowup = FollowUp(id: curID,
                                               jotid: curJotID,
                                               datetime: curDatetime)
                result.append(currentFollowup)
            }
        }
        catch {
            return result
        }
        return result
    }
}

extension FollowUp {
    /// returns the next followup id
    static var nextId: Int {
        let followupTable = Table("followup")
        let id = Expression<Int>("id")
        
        guard let conn = DatabaseManager.shared.conn else {
            return 0
        }
        
        return 1 + ((try? conn.scalar(followupTable.select(id.max)) ?? 0) ?? 0)
    }
}
