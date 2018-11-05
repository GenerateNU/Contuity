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

    var presenter: WriteJotPresenter = WriteJotPresenter()

    @IBOutlet private (set) var textView: UITextView!
    @IBOutlet private (set) var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self

        presenter.attachView(self)
        prettify()

        navigationItem.title = "Write Jot"

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped() {
        presenter.createData()
        presenter.text = ""
        textView.text = ""
    }
}

// MARK: - WriteJotViewProtocol
extension WriteJotViewController: WriteJotViewProtocol {

}

extension WriteJotViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter.text = textView.text
    }
}

// MARK: - Prettify
extension WriteJotViewController: Prettify {
    func prettify() {
        saveButton.setTitle("Save!", for: .normal)

        textView.text = "Reza is the best"
        textView.isHidden = false
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 22)
    }
}
