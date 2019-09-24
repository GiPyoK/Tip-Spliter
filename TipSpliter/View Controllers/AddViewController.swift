//
//  AddViewController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var jobLabel: UITextField!
    @IBOutlet weak var percentageLabel: UITextField!
    
    var employeeController: EmployeeController?
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let employee = employee {
            nameLabel.text = employee.name
            jobLabel.text = employee.job
            percentageLabel.text = String(employee.percentage)
            navigationItem.title = "Edit"
        } else {
            navigationItem.title = "Add Employee"
        }
    }
    @IBAction func saveButtonTabbed(_ sender: UIBarButtonItem) {
        guard let employeeController = employeeController,
                let name = nameLabel.text, !name.isEmpty,
                let job = jobLabel.text, !job.isEmpty,
                let percentage = percentageLabel.text, !percentage.isEmpty,
                let percentageInt = Int(percentage) else { return }
        
        if let employee = employee {
            employeeController.update(employee: employee, name: name, job: job, percentage: percentageInt)
        } else {
            employeeController.create(name: name, job: job, percentage: percentageInt)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTabbed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
