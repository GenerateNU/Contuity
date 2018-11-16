//
//  ExploreViewController.swift
//  Contuity
//
//  Created by Anthony on 10/15/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

// View Protocol for the Explore View
protocol ExploreViewProtocol: class {}

// View Controller for the Explore View
class ExploreViewController: UITableViewController {
    
    private (set) var presenter = ExplorePresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        var jots: [Jot] = []
        presenter.attachView(self)
        do {
            jots = try presenter.getJots()
        }
        catch {}
        prettify()
        let nib = UINib(nibName: "JotTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "JotTableViewCell")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.jots.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "JotTableViewCell"
        let jot = presenter.jots[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JotTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = jot.data
        return cell
    }
}

extension ExploreViewController: ExploreViewProtocol {}

extension ExploreViewController: Prettify {
    func prettify() {}
}
