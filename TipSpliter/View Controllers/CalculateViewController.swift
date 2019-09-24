//
//  CalculateViewController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var employeeController = EmployeeController.sharedEmployeeController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return employeeController.employeeJobs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let job = employeeController.employeeJobs[section]
        var cellCounter = 0
        for i in employeeController.employees.indices {
            if job == employeeController.employees[i].job {
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
        for i in employeeController.employeeJobs.indices {
            if employeeController.employeeJobs[i] == employeeController.employeeJobs[section] {
                return employeeController.employeeJobs[section]
            }
        }
        return nil
    }
    
    
    private func employeeAs(indexPath: IndexPath) -> Employee {
        var employees: [Employee] = []
        for i in employeeController.employees.indices {
            if employeeController.employees[i].job == employeeController.employeeJobs[indexPath.section] {
                employees.append(employeeController.employees[i])
            }
        }
        return employees[indexPath.row]
    }
    
    
}
