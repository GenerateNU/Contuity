//
//  WriteJotViewController.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

/// View Protocol for Writing Jots
protocol WriteJotViewProtocol: class {

}

/// View controller for writing new Jots
class WriteJotViewController: UIViewController {

    private (set) var presenter = WriteJotPresenter()

    @IBOutlet private (set) var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)
        prettify()

        navigationItem.title = "Write Jot"
    }
}

// MARK: - WriteJotViewProtocol
extension WriteJotViewController: WriteJotViewProtocol {

}

// MARK: - Prettify
extension WriteJotViewController: Prettify {
    func prettify() {
        textView.text = "Reza is the best"
        textView.isHidden = false
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 22)
    }
}
