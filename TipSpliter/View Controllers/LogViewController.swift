//
//  LogViewController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/25/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    @IBOutlet weak var logTextView: UITextView!
    
    var employeeController = EmployeeController.sharedEmployeeController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logTextView.text = employeeController.logText
    }
}
