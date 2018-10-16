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

extension Jot: DatabaseInitializationProtocol {
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
            try DatabaseManager.shared.conn?.run(table.create{ t in
                t.column(id, primaryKey: true)
                t.column(data)
                t.column(queue)
                t.column(createdAt)
                t.column(modifiedAt)
                t.column(longitude)
                t.column(latitude)
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
}
