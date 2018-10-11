//
//  WriteJotViewController.swift
//  Contuity
//
//  Created by Anand Kumar on 10/4/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

protocol WriteJotViewProtocol: class {

}

class WriteJotViewController: UIViewController {

    private var presenter = WriteJotPresenter()

    @IBOutlet private (set) var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)

        textView.text = "Reza is the best"
        textView.isHidden = false
        textView.isEditable = true
    }
}

extension WriteJotViewController: WriteJotViewProtocol {

}
