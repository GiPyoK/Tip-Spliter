//
//  EmployeeTableViewCell.swift
//  TipSplitter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var employee: Employee? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let employee = employee else { return }
        
        nameLabel.text = employee.name
        percentageLabel.text = "\(employee.percentage)%"
    }
}
