//
//  EmployeeTableViewCell.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    // Calculate Tip Cell
    @IBOutlet weak var tipNameLabel: UILabel!
    @IBOutlet weak var tipPercentagleLabel: UILabel!
    @IBOutlet weak var tipAmoundLabel: UILabel!
    
    // Add Cell
    @IBOutlet weak var AddNameLabel: UILabel!
    @IBOutlet weak var AddPercentageLabel: UILabel!
    @IBOutlet weak var addJobLabel: UILabel!
    
    // Employees Cell
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Add View Controller
    @IBAction func AddCheckButtonTabbed(_ sender: UIButton) {
    }
}
