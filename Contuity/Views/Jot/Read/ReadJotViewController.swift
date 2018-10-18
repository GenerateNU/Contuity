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
    
    var presenter = ReadJotPresenter()
    
    @IBOutlet private (set) var textView: UITextView!
    @IBOutlet private (set) var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(self)
        prettify()
        
        navigationItem.title = "Read Jot"
    }
}

extension ReadJotViewController: ViewProtocol {

}

extension ReadJotViewController: Prettify {
    func prettify() {
        
    }
}
