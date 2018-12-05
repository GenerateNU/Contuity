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
        return "INSERT INTO initiative (name, parent)"
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
        let name = Expression<String>("name")
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

    static var initiatives: [Initiative] {
        var initiatives: [Initiative] = []
        guard let conn = DatabaseManager.shared.conn
            else {
                return []
        }
        do {
            for row in try conn.prepare("SELECT * FROM initiative") {
                try initiatives.append(parseRow(row: row))
            }
            return initiatives
        }
        catch {
            return []
        }
    }
}

/// This extension contains functionality pertaining to initiative name similarity.
extension Initiative {
    /// This function calculates the edit distance between the name of this initiative and the given name.
    func editDistance(givenName: String) -> Int {
        /// initializing 2x2 matrix where each string is an axis
        var matrix: [[Int]] = [[0]]
        for index in 0...name.count {
            matrix.append([index + 1])
        }
        for index in 0...givenName.count {
            matrix[0].append(index + 1)
        }
        let a = "-" + name
        let b = "-" + givenName
        for i in 1...a.count {
            for _ in 1...b.count {
                matrix[i].append(0)
            }
        }
        /// build the matrix
        for i in 1...a.count {
            for j in 1...b.count{
                if a[i] == b[j] {
                    matrix[i][j] = min(1 + matrix[i-1][j], 1 + matrix[i][j-1], matrix[i-1][j-1])
                }
                else {
                    matrix[i][j] = 1 + min(matrix[i-1][j], matrix[i][j-1], matrix[i-1][j-1])
                }
            }
        }
        return matrix[a.count][b.count]
    }

    /// This function uses some similarityHeuristic, which is a threshold for an acceptable amount of error
    /// at which point a name is called similar, to decide if two initiatives have similar names.
    func similarInitiative(givenInitiative: Initiative ) -> Bool {
        let similarityHeuristic = 0.25
        let editDist = self.editDistance(givenName: givenInitiative.name)
        print(Double(editDist) / Double(name.count))
        if Double(editDist) / Double(name.count) < similarityHeuristic {
            return true
        }
        else {
            return false
        }
    }
}
