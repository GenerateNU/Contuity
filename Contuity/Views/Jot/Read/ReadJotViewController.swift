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
//    var backPage: PresenterProtocol
//    init(PresenterType: previousPage) {
//        backPage = previousPage
//    }
    var presenter = ReadJotPresenter()
    /// MARK - properties
    @IBOutlet weak var edit: UIBarButtonItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var readOnlyJot: UITextView!
    @IBOutlet weak var navigation: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        prettify()
        readOnlyJot.text = presenter.text
        navigation.title = "Jot"
        navigationItem.title = "Read Jot"
    }
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        /// code to go to the write jot page for this jot
        navigationController?.pushViewController(WriteJotViewController(), animated: true)
    }
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        /// code to go back to the previous page using field "backPage"
    }
}

extension ReadJotViewController: ViewProtocol {

}

extension ReadJotViewController: Prettify {
    func prettify() {
        readOnlyJot.isEditable = false
        readOnlyJot.font = .systemFont(ofSize: 22)
    }
}
