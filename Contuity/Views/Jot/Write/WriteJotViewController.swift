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

        saveButton.addTarget(self, action: #selector(processTextToSave), for: .touchUpInside)
    }

    /// When the save button is tapped, this is triggered to notify the user they are about to save
    /// A jot with new initiatives attached.
    @objc private func processTextToSave() {
        let hasNewInitiatives = presenter.update
            ? Set((Jot.read(givenID: presenter.jotID)?.data ?? "").taggedWords)
                .isSubset(of: presenter.text.taggedWords)
            : presenter.text.taggedWords.count > 0

        if hasNewInitiatives {
            showNewInitiativesAlert()
        } else {
            saveTextAsJot()
        }
    }

    /// Present an alert to indicate new initiatives have been added to this Jot. If the user taps Yes button,
    /// they acknowledge this and the save is processed. Tapping the no button is a simple cancel routine.
    private func showNewInitiativesAlert() {
        let confirmNewInitiativesAlert = UIAlertController(
            title: "Add new initiatives?",
            message: "Are you sure would like to add new initiatives?",
            preferredStyle: .alert)
        confirmNewInitiativesAlert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.saveTextAsJot()
        })
        confirmNewInitiativesAlert.addAction(UIAlertAction(title: "No", style: .cancel))

        presentInMainThread(confirmNewInitiativesAlert, isAnimated: true)
    }

    /// Saves text to the database using the presenter
    private func saveTextAsJot() {
        presenter.saveJot()
        if presenter.update {
            navigationController?.popViewController(animated: true)
        }
        else {
            let rjvc = ReadJotViewController()
            rjvc.jotID = presenter.jotID
            navigationController?.pushViewController(rjvc, animated: true)
            textView.text = ""
        }
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
        textView.text = presenter.text
        textView.isHidden = false
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 22)
    }
}
