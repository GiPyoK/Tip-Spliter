//
//  TipTableViewCell.swift
//  TipSplitter
//
//  Created by Gi Pyo Kim on 9/24/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class TipTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentagleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!

    var employee: Employee? {
        didSet {
            updateViews()
        }
    }
    
    
    
    private func updateViews() {
        guard let employee = employee else { return }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        nameLabel.text = employee.name
        percentagleLabel.text = "\(employee.percentage)%"
        if let formattedTipAmount = formatter.string(from: employee.tip as NSNumber) {
            tipAmountLabel.text = "\(formattedTipAmount)"
        }
        
    }
    
    
}
