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
        guard let conn = DatabaseManager.shared.conn else {
            return nil
        }
        do {
            for row in try conn.prepare("SELECT * FROM followup WHERE id = \(givenID)") {
                guard let optionalID: Int64 = row[0] as? Int64,
                        let optionalJotID: Int64  = row[1] as? Int64 else {
                                return nil
                }
                let curID = Int(optionalID)
                let curJotID = Int(optionalJotID)
                var curDatetime = ""
                let row2 = row[2]
                switch row2 {
                case let row2 as String:
                    curDatetime = String(row2)
                default:
                    break
                }
                return FollowUp(id: curID, jotid: curJotID, datetime: curDatetime)
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    static func readAll(givenJotID: Int) -> [FollowUp] {
        var result: [FollowUp] = []
        guard let conn = DatabaseManager.shared.conn
            else {
                return result
        }
        do {
            for row in try conn.prepare("SELECT * FROM followup WHERE jotid = \(givenJotID)") {
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
            // TODO: throw selectionfailure
            // this means we have a partial list
            return result
        }
        return result
    }
}
