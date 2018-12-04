//
//  ReadJotViewController.swift
//  Contuity
//
//  Created by Reza Akhtar on 18.10.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import Foundation
import UIKit

class ReadJotViewController: UIViewController {
    var jotID: Int = 1 // TODO: this needs to be set to the given jotID in a constructor
    var presenter: ReadJotPresenter = ReadJotPresenter()
    
    
    /// MARK - properties
    @IBOutlet private (set) var readJotTextView: UITextView!
    @IBOutlet private (set) var backButton: UIButton!
    @IBOutlet private (set) var editButton: UIButton!
    @IBOutlet private (set) var attributes: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        prettify()
        navigationItem.title = "Read Jot"
    }
    // This method pushes an editable view of this jot over this readable view.
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let editWriteJotVC = WriteJotViewController()
        editWriteJotVC.presenter.setJotID(givenID: jotID)
        editWriteJotVC.presenter.update = true
        navigationController?.pushViewController(editWriteJotVC, animated: true)
    }
    // This method pops this view off of the stack, thus going back to the previous view.
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ReadJotViewController: Prettify {
    func prettify() {
        readJotTextView.text = presenter.getText(jotID: self.jotID)
        readJotTextView.isHidden = false
        readJotTextView.isEditable = false
        readJotTextView.font = .systemFont(ofSize: 22)
        attributes.text = ""
        let followups = FollowUp.readAll(givenJotID: jotID)
        if !followups.isEmpty {
            attributes.text = "Follow Up times:"
        }
        followups.forEach {
            attributes.text += "\n" + $0.datetime
        }
    }
}
