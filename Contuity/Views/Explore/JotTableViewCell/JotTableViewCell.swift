//
//  JotTableViewCell.swift
//  Contuity
//
//  Created by Anthony on 10/18/18.
//  Copyright © 2018 Generate. All rights reserved.
//

import UIKit

class JotTableViewCell: UITableViewCell {
    
    @IBOutlet private (set) var jotText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
