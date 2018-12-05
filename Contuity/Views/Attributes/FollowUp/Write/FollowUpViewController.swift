//
//  FollowUpViewController.swift
//  Contuity
//
//  Created by Reza Akhtar on 28.11.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

/// this class represents a FollowUpViewController which allows the user to enter a date.
class FollowUpViewController: UIViewController {
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    var date: Date = Date()

    @IBAction func enterButtonTapped(_ sender: Any) {
        date = datePicker.date
        print(datePicker.date)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // returns the date of this FollowUpViewController
    func getDate() -> Date {
        return date
    }
}
