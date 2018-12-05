//
//  StringExtension.swift
//  Contuity
//
//  Created by Anand Kumar on 11/1/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation

// MARK: - A useful extension on the standard String class.
extension String {

    /// Finds all instances of initiatives in a string.
    /// Iterative scan using regex
    /// All valid initiatives are in the form #<initiative> where initiative has 1+ letter (case insensitive)
    /// and any number of digits.
    /// - Returns a list of Strings representing the Initiatives found.
    var taggedWords: [String] {
        let regex = try? NSRegularExpression(
            pattern: "#[0-9]*[a-z]+[a-z0-9]*",
            options: .caseInsensitive)

        let string = self as NSString
        return regex?.matches(in: self,
                              options: [],
                              range: NSRange(location: 0, length: string.length)).map {
            string.substring(with: $0.range)
        } ?? []
    }
}

extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
