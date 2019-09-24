//
//  TipTableViewCell.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/24/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class TipTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentagleLabel: UILabel!
    @IBOutlet weak var tipAmoundLabel: UILabel!

    var employee: Employee? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let employee = employee else { return }
        
        if employee.hasWorked {
            nameLabel.text = employee.name
            percentagleLabel.text = "\(employee.percentage)%"
            tipAmoundLabel.text = "$ \(employee.tip)"
        }
    }
}
