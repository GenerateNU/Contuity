//
//  FollowupTableViewCell.swift
//  Contuity
//
//  Created by Anand Kumar on 11/29/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

/// Represents a single cell in the follow-up table, which displays the text of the jot
/// on the left and the date of the followup on the right
class FollowupTableViewCell: UITableViewCell {

    @IBOutlet private (set) var jotTextView: UITextView!
    @IBOutlet private (set) var dateTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Sets the jot text and date text using a given followup.
    ///
    /// - Parameter followup: The given FollowUp model.
    func update(with followup: FollowUp) {
        if let jot = try? Jot.read(givenID: followup.jotid) {
            jotTextView.text = jot.data
            dateTextView.text = followup.datetime
        }
    }
}
