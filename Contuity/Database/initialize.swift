//
//  initialize.swift
//  Contuity
//
//  Created by Lexi Spikerman on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import SQLite

func createJotTable(db: Connection) {
    let jot = Table("jot")
    let id = Expression<Int>("id")
    let data = Expression<String>("data")
    let queue = Expression<Bool>("queue")
    let createdat = Expression<Date>("createdat")
    let modifiedat = Expression<Date>("modifiedat")
    let longitude = Expression<Double>("longitude")
    let latitude = Expression<Double>("latitude")
    
    do {
        try db.run(jot.create { t in
            t.column(id, primaryKey: true)
            t.column(data)
            t.column(queue)
            t.column(createdat)
            t.column(modifiedat)
            t.column(longitude)
            t.column(latitude)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createPeopleTable(db: Connection) {
    let people = Table("people")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let number = Expression<String>("number")
    let email = Expression<String>("email")
    let createdat = Expression<Date>("createdat")
    
    do {
        try db.run(people.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(number)
            t.column(email)
            t.column(createdat)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createJotPeopleTable(db: Connection) {
    let jotpeople = Table("jotpeople")
    let jotid = Expression<Int>("jotid")
    let peopleid = Expression<Int>("peopleid")

    do {
        try db.run(jotpeople.create { t in
            t.column(jotid, primaryKey: true)
            t.column(peopleid, primaryKey: true)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createEventTable(db: Connection) {
    let event = Table("event")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let longitude = Expression<Double>("longitude")
    let latitude = Expression<Double>("latitude")
    let eventtime = Expression<Date>("eventtime")
    let createdat = Expression<Date>("createdat")
    
    do {
        try db.run(event.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(longitude)
            t.column(latitude)
            t.column(eventtime)
            t.column(createdat)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(String(describing: statement))")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createJotEventTable(db: Connection) {
    let jotevent = Table("jotevent")
    let jotid = Expression<Int>("jotid")
    let eventid = Expression<Int>("eventid")
    
    do {
        try db.run(jotevent.create { t in
            t.column(jotid, primaryKey: true)
            t.column(eventid, primaryKey: true)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createFollowUpTable(db: Connection) {
    let followup = Table("followup")
    let id = Expression<Int>("id")
    let jotid = Expression<Int>("jotid")
    let text = Expression<String>("text")
    let datetime = Expression<Date>("datetime")
    
    do {
        try db.run(followup.create { t in
            t.column(id, primaryKey: true)
            t.column(jotid)
            t.column(text)
            t.column(datetime)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createReminderTable(db: Connection) {
    let reminder = Table("reminder")
    let id = Expression<Int>("id")
    let jotid = Expression<Int>("jotid")
    let type = Expression<String>("type")
    
    do {
        try db.run(reminder.create { t in
            t.column(id, primaryKey: true)
            t.column(jotid)
            t.column(type)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func createInitiativeTable(db: Connection) {
    let jot = Table("jot")
    let id = Expression<Int>("id")
    let jotid = Expression<Int>("jotid")
    let name = Expression<String>("name")
    let parent = Expression<Int>("parent")

    do {
        try db.run(jot.create { t in
            t.column(id, primaryKey: true)
            t.column(jotid)
            t.column(name)
            t.column(parent)
        })
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}

func initialize() {
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    
    do {
        let db = try Connection("\(path)/db.sqlite3")

        createJotTable(db: db)
        createPeopleTable(db: db)
        createJotPeopleTable(db: db)
        createEventTable(db: db)
        createJotEventTable(db: db)
        createFollowUpTable(db: db)
        createReminderTable(db: db)
        createInitiativeTable(db: db)
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("constraint failed: \(message), in \(statement)")
    } catch let error {
        print("insertion failed: \(error)")
    }
}
