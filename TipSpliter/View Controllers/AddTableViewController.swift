//
//  AddTableViewController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

protocol AddTableViewControllerDelegate {
    func updateEmployeeController () -> EmployeeController
}

class AddTableViewController: UITableViewController {
    
    var delegate: AddTableViewControllerDelegate?
    var employeeController: EmployeeController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        employeeController =  delegate?.updateEmployeeController()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let employeeController = employeeController else { return 0 }
        
        return employeeController.employeeJobs.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let employeeController = employeeController else { return 0 }

        let job = employeeController.employeeJobs[section]
        var cellCounter = 0
        for i in employeeController.employees.indices {
            if job == employeeController.employees[i].job {
                cellCounter += 1
            }
        }
        return cellCounter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeeTableViewCell,
            let employee = employeeAs(indexPath: indexPath) else { return UITableViewCell() }
        
        cell.employee = employee
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let employeeController = employeeController else { return nil }

        for i in employeeController.employeeJobs.indices {
            if employeeController.employeeJobs[i] == employeeController.employeeJobs[section] {
                return employeeController.employeeJobs[section]
            }
        }
        return nil
    }
    
    
    private func employeeAs(indexPath: IndexPath) -> Employee? {
        guard let employeeController = employeeController else { return nil }
        
        var employees: [Employee] = []
        for i in employeeController.employees.indices {
            if employeeController.employees[i].job == employeeController.employeeJobs[indexPath.section] {
                employees.append(employeeController.employees[i])
            }
        }
        return employees[indexPath.row]
    }

}
