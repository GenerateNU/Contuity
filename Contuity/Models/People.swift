//
//  People.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/2/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

class People {
    
    var id: Int
    var name: String?
    var number: String?
    var email: String?
    var createdat: String
    
    init(id: Int, name: String, number: String?, email: String?, createdat: String){
        self.id = id
        self.name = name
        self.number = number
        self.email = email
        self.createdat = createdat
    }
}

extension People: Equatable {
    static func == (lhs: People, rhs: People) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.number == rhs.number &&
            lhs.createdat == rhs.createdat &&
            lhs.email == rhs.email
    }
}

extension People: DatabaseProtocol {
    
    static func createTable() throws {
        let table = Table("people")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let number = Expression<Bool>("number")
        let createdat = Expression<String>("createdat")
        let email = Expression<String>("email")
        
        do {
            try DatabaseManager.shared.conn?.run(
                table.create { t in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(number)
                    t.column(createdat)
                    t.column(email)
            })
        } catch let Result.error(_, code, _) where code == SQLITE_CONSTRAINT {
            throw DatabaseError.constraintFailed
        } catch {
            throw DatabaseError.insertionFailed
        }
    }
    // This function writes a new people to the database.
    func write() {
        let insert = "INSERT INTO people (id, name, number, createdat, email)"
        let values =
        "VALUES (\(id), \"\(String(describing: name))\", \(number ?? ""), \"\(createdat)\", \(email ?? "")"
        
        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare("\(insert) \(values)") else {
                return
        }
        _ = try? statement.run()
    }
    // This function updates the given jot.
    func update() {
        let nameMessage = "name = \(String(describing: name ))"
        let createdatMessage = "createdat = \"\(createdat)\""
        let emailMessage = "email = \(email ?? "")"
        let numberMessage = "number = \(number ?? "")"
        let setMessage = "\(nameMessage), \(createdatMessage), \(emailMessage), \(numberMessage)"
        let update = "UPDATE people SET \(setMessage) WHERE id = \(id)"
        
        guard let conn = DatabaseManager.shared.conn,
            let statement = try? conn.prepare(update) else {
                return
        }
        _ = try? statement.run()
    }
}

extension People {
    // This function returns the jot with the given id if one exists.
    static func read(givenID: Int) -> People? {
        guard let conn = DatabaseManager.shared.conn
            else {
                print("conn")
                return nil
        }
        do {
            for row in try conn.prepare("SELECT * FROM people WHERE id = \(givenID)") {
                guard let optionalID: Int64 = row[0] as? Int64,
                    let name = row[1] as? String else {
                        break
                }
                let id = Int(optionalID)
                guard let number = row[2] as? String? else {
                    break
                }
                var newCreatedAt = ""
                let createdatTemp = row[3]
                switch createdatTemp {
                case let createdatTemp as String:
                    newCreatedAt = String(createdatTemp)
                default:
                    break
                }
                guard let email = row[2] as? String? else {
                    break
                }
                
                return People(id: id,
                           name: name,
                           number: number,
                           email: email,
                           createdat: newCreatedAt)
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    static var nextId: Int {
        let peopleTable = Table("people")
        let id = Expression<Int>("id")
        
        guard let conn = DatabaseManager.shared.conn else {
            return 0
        }
        
        return 1 + ((try? conn.scalar(peopleTable.select(id.max)) ?? 0) ?? 0)
    }
}
