//
//  TodayViewController.swift
//  Contuity
//
//  Created by Reza Akhtar on 02.12.18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

// View Protocol for the Today View
protocol TodayViewProtocol: class {
    
}

// View Controller for the Today View
class TodayViewController: UITableViewController {
    private (set) var presenter = TodayPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        prettify()
        let nib = UINib(nibName: "FollowupTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FollowupTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.followups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FollowupTableViewCell"
        let followup = presenter.followups[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FollowupTableViewCell else {
            return UITableViewCell()
        }
        cell.update(with: followup)
        return cell
    }
}

extension TodayViewController: TodayViewProtocol {}

extension TodayViewController: Prettify {
    func prettify() {}
}
