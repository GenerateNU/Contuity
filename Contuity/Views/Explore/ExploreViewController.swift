//
//  ExploreViewController.swift
//  Contuity
//
//  Created by Anthony on 10/15/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

// View Protocol for the Explore View
protocol ExploreViewProtocol: class {
    
}

// View Controller for the Explore View
class ExploreViewController: UITableViewController {
    
    private (set) var presenter = ExplorePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(self)
        presenter.jots += presenter.getJots()
        
        prettify()
        
        let nib = UINib(nibName: "JotTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "JotTableViewCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.jots.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "JotTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JotTableViewCell else {
            fatalError("The dequeued cell is not of type JotTableViewCell")
        }
        
        let jot = presenter.jots[indexPath.row]
        cell.textLabel!.text = jot.data
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - ExploreViewProtocol
extension ExploreViewController: ExploreViewProtocol {
    
}

extension ExploreViewController: Prettify {
    func prettify() {
        
    }
}
