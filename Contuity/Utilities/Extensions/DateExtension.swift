//
//  DateExtension.swift
//  Contuity
//
//  Created by Anand Kumar on 10/13/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

extension Date {
    /// Constructs a readable timestamp of a date
    ///
    /// - Returns: String, i.e 04-20-6969 10:55:30
    func timestamp() -> String {
        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"

        return formatter.string(from: self)
    }

    /// Constructs a date object from a timestamp
    ///
    /// - Returns: Date from a timestamp in a form like: 04-20-6969 10:55:30
    static func date(from timestamp: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"

        return dateFormatter.date(from: timestamp)
    }
}
