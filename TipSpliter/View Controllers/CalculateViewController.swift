//
//  CalculateViewController.swift
//  TipSplitter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cashTipTextField: UITextField!
    @IBOutlet weak var cardTipTextField: UITextField!
    @IBOutlet weak var totalTipTextField: UILabel!
    
    var employeeController = EmployeeController.sharedEmployeeController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        // hide keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        tableView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func calculateTabbed(_ sender: Any) {
        if let cashTipString = cashTipTextField.text, !cashTipString.isEmpty, let cashTip = Double(cashTipString),
            let cardTipString = cardTipTextField.text, !cardTipString.isEmpty, let cardTip = Double(cardTipString) {
            
            let totalTip = cashTip + cardTip
            
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            if let formattedTipAmount = formatter.string(from: totalTip as NSNumber) {
                totalTipTextField.text = "Total Tip \(formattedTipAmount)"
            }
            calculateTip(totalTip: totalTip)
            employeeController.createLog(totalTip: totalTip)
            tableView.reloadData()
        }
        view.endEditing(true)
    }
    
    private func calculateTip (totalTip: Double) {
        var totalPercentage = 0.0
        for i in employeeController.hasWorkedEmployees.indices {
            totalPercentage += Double(employeeController.hasWorkedEmployees[i].percentage)
        }
        totalPercentage /= 100.0
        let baseTip = totalTip / totalPercentage
        for i in employeeController.employees.indices {
            if employeeController.employees[i].hasWorked {
                employeeController.employees[i].tip = baseTip * Double(employeeController.employees[i].percentage) / 100.0
            }
        }
    }
}

extension CalculateViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return employeeController.hasWorkedJobs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let job = employeeController.hasWorkedJobs[section]
        var cellCounter = 0
        for i in employeeController.hasWorkedEmployees.indices {
            if job == employeeController.hasWorkedEmployees[i].job {
                cellCounter += 1
            }
        }
        return cellCounter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell", for: indexPath) as? TipTableViewCell else { return UITableViewCell() }
        
        cell.employee = employeeAs(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in employeeController.hasWorkedJobs.indices {
            if employeeController.hasWorkedJobs[i] == employeeController.hasWorkedJobs[section] {
                return employeeController.hasWorkedJobs[section]
            }
        }
        return nil
    }
    
    
    private func employeeAs(indexPath: IndexPath) -> Employee {
        var employees: [Employee] = []
        for i in employeeController.hasWorkedEmployees.indices {
            if employeeController.hasWorkedEmployees[i].job == employeeController.hasWorkedJobs[indexPath.section] {
                employees.append(employeeController.hasWorkedEmployees[i])
            }
        }
        return employees[indexPath.row]
    }
    
    
}
