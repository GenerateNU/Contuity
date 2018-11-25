//
//  Jot.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

/**
 Jots represent the notes and memos users can write.
 */
struct Jot {
    let id: Int
    var data: String
    var queue: Bool
    let createdAt: String
    var modifiedAt: String?
    var latitude: Double?
    var longitude: Double?
}

extension Jot: Equatable {
    static func == (lhs: Jot, rhs: Jot) -> Bool {
        return lhs.id == rhs.id &&
            lhs.data == rhs.data &&
            lhs.queue == rhs.queue &&
            lhs.createdAt == rhs.createdAt &&
            lhs.modifiedAt == rhs.modifiedAt &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}

extension Jot: DatabaseProtocol {
    
    static func createTable() throws {
        let table = Table("jot")
        let id = Expression<Int>("id")
        let data = Expression<String>("data")
        let queue = Expression<Bool>("queue")
        let createdAt = Expression<String>("createdAt")
        let modifiedAt = Expression<String>("modifiedAt")
        let latitude = Expression<Double>("latitude")
        let longitude = Expression<Double>("longitude")
 
        do {
            try DatabaseManager.shared.conn?.run(
                table.create { t in
                    t.column(id, primaryKey: true)
                    t.column(data)
                    t.column(queue)
                    t.column(createdAt)
                    t.column(modifiedAt)
                    t.column(latitude)
                    t.column(longitude)
            })
        } catch let Result.error(_, code, _) where code == SQLITE_CONSTRAINT {
            throw DatabaseError.constraintFailed
        } catch {
            throw DatabaseError.insertionFailed
        }
    }

    // This function writes a new jot to the database.
    func write() {
        let insert = "INSERT INTO jot (id, data, queue, createdAt, modifiedAt, latitude, longitude)"
        let values =
        "VALUES (\(id), \"\(data)\", \(queue), \"\(createdAt)\", \"\(modifiedAt ?? createdAt)\", \(latitude ?? 0), \(longitude ?? 0))"

        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare("\(insert) \(values)") else {
                return
        }
        _ = try? statement.run()
    }

    // This function updates the given jot.
    func update() {
        let dataMessage = "data = \"\(data)\""
        let queueMessage = "queue = \(queue)"
        let createdMessage = "createdAt = \"\(createdAt)\""
        let modifiedMessage = "modifiedAt = \"\(modifiedAt ?? createdAt)\""
        let latMessage = "latitude = \(latitude ?? 0)"
        let longMessage = "longitude = \(longitude ?? 0)"
        let setMessage = "\(dataMessage), \(queueMessage), \(createdMessage), \(modifiedMessage), \(latMessage), \(longMessage)"
        let update = "UPDATE jot SET \(setMessage) WHERE id = \(id)"

        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare(update) else {
                return
        }
        _ = try? statement.run()
    }
}

extension Jot {
    // This function returns the jot with the given id if one exists.
    static func read(givenID: Int) throws -> Jot {
        guard let conn = DatabaseManager.shared.conn
            else {
                throw DatabaseError.selectFailed
        }
        do {
            for row in try conn.prepare("SELECT * FROM jot WHERE id = \(givenID)") {
                return try parseRow(row: row)
            }
        }
        catch {
            throw DatabaseError.selectFailed
        }
        throw DatabaseError.selectFailed
    }
    
    /// Parses a single row from the database into a Jot
    ///
    /// - Parameter row: a row from the database
    /// - Returns: a Jot
    /// - Throws: DatabaseError.selectFailed if the database SELECT failed
    private static func parseRow(row: Statement.Element) throws -> Jot {
        guard let optionalID: Int64 = row[0] as? Int64,
            let newData = row[1] as? String
            else {
                throw DatabaseError.selectFailed
        }
        let id = Int(optionalID)
        let row2 = row[2]
        var newQueue = false
        switch row2 {
        case let row2 as Int64:
            if row2 == 1 {
                newQueue = true
            }
        default:
            break
        }
        var newCreatedAt = ""
        let row3 = row[3]
        switch row3 {
        case let row3 as String:
            newCreatedAt = String(row3)
        default:
            throw DatabaseError.selectFailed
        }
        guard let newModifiedAt = row[4] as? String? else{
            throw DatabaseError.selectFailed
        }
        var newLat: Double?
        let row5 = row[5]
        switch row5 {
        case let row5 as Double:
            newLat = Double(row5)
        default:
            throw DatabaseError.selectFailed
        }
        var newLong: Double?
        let row6 = row[6]
        switch row6 {
        case let row6 as Double:
            newLong = Double(row6)
        default:
            throw DatabaseError.selectFailed
        }
        return Jot(id: id,
                   data: newData,
                   queue: newQueue,
                   createdAt: newCreatedAt,
                   modifiedAt: newModifiedAt,
                   latitude: newLat,
                   longitude: newLong)
    }
    /// Returns a set of Jots from the database
    /// de
    /// - Parameter queue: if queue is true only get jots where queue = true, otherwise get all jots
    /// - Returns: an array of Jots
    /// - Throws: DatabaseError.selectFailed if SELECT operation on database failed
    static func getJots(queue: Bool) throws -> [Jot] {
        var jots: [Jot] = []
        guard let conn = DatabaseManager.shared.conn
            else {
                throw DatabaseError.selectFailed
        }
        do {
            var select = "SELECT * FROM jot"
            if queue {
                select += "where queue = true"
            }
            for row in try conn.prepare(select) {
                let jot = try parseRow(row: row)
                jots.append(jot)
            }
        }
        catch {
            throw DatabaseError.selectFailed
        }
        return jots
    }
}
