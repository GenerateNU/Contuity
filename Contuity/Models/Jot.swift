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
    var data: String?
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

    func write() {
        let insert = "INSERT INTO jot (id, data, queue, createdAt, modifiedAt, latitude, longitude)"
        let values =
        "VALUES (\(id), \"\(data ?? "")\", \(queue), \"\(createdAt)\", \"\(createdAt)\", \(latitude ?? 0), \(longitude ?? 0))"

        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare("\(insert) \(values)") else {
                return
        }
        _ = try? statement.run()
    }
    
    static func read(givenID: Int) -> Jot? {
        guard let conn = DatabaseManager.shared.conn
            else {
                print("conn")
                return nil
        }
        do {
            for row in try conn.prepare("SELECT * FROM jot WHERE id = \(givenID)") {
                guard let optionalID: Int64 = row[0] as? Int64 else {
                    break
                }
                let id = Int(optionalID)
                guard let newData = row[1] as? String? else{
                    break
                }
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
                    break
                }
                guard let newModifiedAt = row[4] as? String? else{
                    break
                }
                var newLat: Double?
                let row5 = row[5]
                switch row5 {
                case let row5 as Double:
                    newLat = Double(row5)
                default:
                    break
                }
                var newLong: Double?
                let row6 = row[6]
                switch row6 {
                case let row6 as Double:
                    newLong = Double(row6)
                default:
                    break
                }
                return Jot(id: id,
                           data: newData,
                           queue: newQueue,
                           createdAt: newCreatedAt,
                           modifiedAt: newModifiedAt,
                           latitude: newLat,
                           longitude: newLong)
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    func parseRow(row: Statement): Jot {
        guard let optionalID: Int64 = row[0] as? Int64 else {
            break
        }
        let id = Int(optionalID)
        guard let newData = row[1] as? String? else{
            break
        }
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
            break
        }
        guard let newModifiedAt = row[4] as? String? else{
            break
        }
        var newLat: Double?
        let row5 = row[5]
        switch row5 {
        case let row5 as Double:
            newLat = Double(row5)
        default:
            break
        }
        var newLong: Double?
        let row6 = row[6]
        switch row6 {
        case let row6 as Double:
            newLong = Double(row6)
        default:
            break
        }
        return Jot(id: id,
                   data: newData,
                   queue: newQueue,
                   createdAt: newCreatedAt,
                   modifiedAt: newModifiedAt,
                   latitude: newLat,
                   longitude: newLong)
    }
    
    static func getJots(queue: boolean): [Jot] {
        let jots: [Jot] = []
        guard let conn = DatabaseManager.shared.conn
        else {
            print("conn")
            return nil
        }
        do {
            if (queue) {
                for row in try conn.prepare("SELECT * FROM jot where queue = true") {
                    jots.append(parseRow(row))
                }

            } else {
                for row in try conn.prepare("SELECT * FROM jot") {
                    jots.append(parseRow(row))
                }
            }
        }
    }
}
