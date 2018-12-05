//
//  ExploreViewController.swift
//  Contuity
//
//  Created by Anthony on 10/15/18.
//  Copyright © 2018 Generate. All rights reserved.
//
import UIKit
import BTNavigationDropdownMenu

// View Protocol for the Explore View
protocol ExploreViewProtocol: class {}

// View Controller for the Explore View
class ExploreViewController: UITableViewController {
    var displayedJots: [Jot] = []

    private (set) var presenter = ExplorePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        prettify()

        displayedJots = presenter.jots
        var  items: [String] = ["All"]

        items += Initiative.initiatives.map { $0.name }
        let menuView = BTNavigationDropdownMenu(title: BTTitle.index(0), items: items)
        menuView.arrowTintColor = UIColor.black
        self.navigationItem.titleView = menuView
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            if indexPath == 0 {
                self.displayedJots = self.presenter.jots
            } else {
                let initiative = items[indexPath]
                self.displayedJots = self.presenter.filter(initiative: initiative)
                self.tableView.reloadData()
            }
        }

        let nib = UINib(nibName: "JotTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "JotTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedJots.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "JotTableViewCell"
        let jot = displayedJots[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JotTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = jot.data
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rjvc = ReadJotViewController()
        rjvc.jotID = presenter.jots[indexPath.row].id
        navigationController?.pushViewController(rjvc, animated: true)
    }
}

extension ExploreViewController: ExploreViewProtocol {}

extension ExploreViewController: Prettify {
    func prettify() {}
}
