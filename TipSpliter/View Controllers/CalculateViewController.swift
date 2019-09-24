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
        tableView.reloadData()
    }
    
    
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
