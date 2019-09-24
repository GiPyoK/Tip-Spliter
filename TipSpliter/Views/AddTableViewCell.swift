//
//  AddTableViewCell.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/24/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var hasWorkedSwitch: UISwitch!
    
    var employee: Employee? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let employee = employee else { return }
        
        nameLabel.text = employee.name
        percentageLabel.text = "\(employee.percentage)%"
        hasWorkedSwitch.isOn = employee.hasWorked
    }
    @IBAction func switchTabbed(_ sender: UISwitch) {
        
    }

}
