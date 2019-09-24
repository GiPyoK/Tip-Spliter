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
    @IBOutlet weak var hasWorkedSwitch: UISwitch!
    
    // Employees Cell
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
        
//        AddNameLabel.text = employee.name
//        AddPercentageLabel.text = "\(employee.percentage)%"
//        hasWorkedSwitch.isOn = employee.hasWorked
//
//        if employee.hasWorked {
//            tipNameLabel.text = employee.name
//            tipPercentagleLabel.text = "\(employee.percentage)%"
//            tipAmoundLabel.text = "$ \(employee.tip)"
//        }
    }
    
    
    

    // Add View Controller
    @IBAction func switchTabbed(_ sender: UISwitch) {
        
    }
}
