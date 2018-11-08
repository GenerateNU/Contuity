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
    var jotID: Int = 1 // this needs to be set to the given jotID in a constructor
    var presenter: ReadJotPresenter = ReadJotPresenter()
    
    /// MARK - properties
    @IBOutlet private (set) var readJotTextView: UITextView!
    @IBOutlet private (set) var backButton: UIButton!
    @IBOutlet private (set) var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readJotTextView.delegate = self
        presenter.attachView(self)
        presenter.setText(jotID: jotID)
        prettify()
        navigationItem.title = "Read Jot"
    }
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let editWriteJotVC = WriteJotViewController()
        editWriteJotVC.presenter.setJotID(givenID: jotID)
        editWriteJotVC.presenter.update = true
        navigationController?.pushViewController(editWriteJotVC, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        /// code to go back to the previous page using field "backPage"
        navigationController?.popViewController(animated: true)
    }
}

extension ReadJotViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter.text = textView.text
    }
}

extension ReadJotViewController: Prettify {
    func prettify() {
        readJotTextView.text = presenter.text
        readJotTextView.isHidden = false
        readJotTextView.isEditable = false
        readJotTextView.font = .systemFont(ofSize: 22)
    }
}
