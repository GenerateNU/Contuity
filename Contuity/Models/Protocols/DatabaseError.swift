//
//  DatabaseError.swift
//  Contuity
//
//  Created by Anand Kumar on 10/13/18.
//  Copyright © 2018 Generate. All rights reserved.
//

/**
 Enum representation of the different errors database connections can throw

 **cases:**
    - constraintFailed: a constraint was not satisified
    - insertionFailed: table insertion could not be parsed
 */
enum DatabaseError: Error {
    case constraintFailed
    case insertionFailed
    case selectFailed
}
