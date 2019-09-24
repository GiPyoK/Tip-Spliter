//
//  EmployeeTableViewController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class EmployeeTableViewController: UITableViewController {
    
    var employeeController = EmployeeController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return employeeController.employeeJobs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell() }
        
        cell.employee = employeeAs(indexPath: indexPath)
        return cell
        }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in employeeController.employeeJobs.indices {
            if employeeController.employeeJobs[i] == employeeController.employeeJobs[section] {
                return employeeController.employeeJobs[section]
            }
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            for i in employeeController.employees.indices {
                if employeeController.employees[i] == employeeAs(indexPath: indexPath) {
                    employeeController.delete(employee: employeeController.employees[i])
                    tableView.reloadData()
                    break
                }
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEmployeeSegue" {
            if let addVC = segue.destination as? AddViewController {
                addVC.employeeController = employeeController
            }
        } else if segue.identifier == "EditEmployeeSegue" {
            if let addVC = segue.destination as? AddViewController, let indexPath = tableView.indexPathForSelectedRow {
                addVC.employeeController = employeeController
                addVC.employee = employeeAs(indexPath: indexPath)
            }
        }
        
    }

}

extension EmployeeTableViewController: AddTableViewControllerDelegate {
    func updateEmployeeController() -> EmployeeController {
        return employeeController
    }
    
    
}
