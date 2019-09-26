//
//  EmployeeController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation
import UIKit

class EmployeeController {
    var employees: [Employee] = []
    var employeeJobs: [String] = []
    var logText: [String] = []
    
     var hasWorkedEmployees: [Employee] {
        return employees.filter { $0.hasWorked == true }
    }
    
    var hasWorkedJobs: [String] {
        var jobs: [String] = []
        
        for i in hasWorkedEmployees.indices {
            if jobs.count == 0 {
                jobs.append(hasWorkedEmployees[i].job)
            } else {
                var jobExists = false
                for j in jobs.indices {
                    if jobs[j] == hasWorkedEmployees[i].job {
                        jobExists = true
                        break
                    }
                }
                if !jobExists {
                    jobs.append(hasWorkedEmployees[i].job)
                    jobs.sort(by: <)
                }
            }
        }
        return jobs
    }
    
    static var sharedEmployeeController = EmployeeController()
    
    init() {
        loadFromPersistentStore()
    }
    
    func create(name: String, job: String, percentage: Int) {
        let employee = Employee(name: name, job: job , percentage: percentage)
        
        // check duplicate
        for i in employees.indices {
            if employee == employees[i] {
                print ("\(employee.name) has been already added")
                return
            }
        }
        
        employees.append(employee)
        employees.sort(by: <)
        
        if employeeJobs.count == 0 {
            employeeJobs.append(job)
        } else {
            var jobExists = false
            for i in employeeJobs.indices {
                if job == employeeJobs[i] {
                    jobExists = true
                    break
                }
                
            }
            if !jobExists {
                employeeJobs.append(job)
                employeeJobs.sort(by: <)
            }
        }
        saveToPersistentStore()
    }
    
    func update(employee: Employee, name: String, job: String, percentage: Int) {
        for i in employees.indices {
            if employees[i] == employee {
                if employees[i].job != job {
                    
                    var jobExists = true
                    for j in employees.indices {
                        if employees[i] != employees[j] && employees[i].job != employees[j].job {
                            jobExists = false
                        }
                    }
                    if !jobExists {
                        for k in employeeJobs.indices {
                            if employees[i].job == employeeJobs[k] {
                                employeeJobs.remove(at: k)
                                break
                            }
                        }
                    }
                    var newJobExists = false
                    for l in employeeJobs.indices {
                        if job == employeeJobs[l] {
                            newJobExists = true
                            break
                        }
                    }
                    if !newJobExists {
                        employeeJobs.append(job)
                        employeeJobs.sort(by: <)
                    }
                    
                    
                }
                employees[i].name = name
                employees[i].percentage = percentage
                employees[i].job = job
                employees.sort(by: <)
                saveToPersistentStore()
            }
            
        }
    }
    
    func delete(employee: Employee) {
        for i in employees.indices {
            if employee == employees[i] {
                
                var jobExists = false
                for k in employees.indices {
                    if employees[i] != employees[k] && employees[i].job == employees[k].job {
                        jobExists = true
                        break
                    }
                }
                
                if !jobExists {
                    for j in employeeJobs.indices {
                        if employee.job == employeeJobs[j] {
                            employeeJobs.remove(at: j)
                            break
                        }
                    }
                    
                }
                employees.remove(at: i)
                saveToPersistentStore()
                break
            }
        }
    }
    
    func updateHasWorked(for employee: Employee) {
        for i in employees.indices {
            if employees[i] == employee {
                employees[i].hasWorked = !employee.hasWorked
                if !employees[i].hasWorked {
                    employees[i].tip = 0
                }
                saveToPersistentStore()
                break
            }
        }
    }
    
    func createLog(totalTip: Double) {
        var tippedEmployees: [Employee] {
            return employees.filter { $0.tip > 0.0 }
        }
        
        if tippedEmployees.count > 0 {
            let numFormatter = NumberFormatter()
            numFormatter.locale = Locale.current
            numFormatter.numberStyle = .currency
            
            let currentDateTime = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .long
            
            var log = "\(dateFormatter.string(from: currentDateTime))\n"
            if let formattedTotalTip = numFormatter.string(from: totalTip as NSNumber) {
                log += "Total Tip \(formattedTotalTip)\n"
            }
            for i in tippedEmployees.indices {
                if let formattedTipAmount = numFormatter.string(from: tippedEmployees[i].tip as NSNumber) {
                    log += "\(tippedEmployees[i].name)\t\t\(formattedTipAmount)\n"
                }
            }
            logText.insert(log + "\n", at: 0)
            saveToPersistentStore()
        }
    }
    
    // Persistence
    private var employeeListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("EmployeeList.plist")
    }
    
    private var jobListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("JobList.plist")
    }
    
    private var logURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("Log.plist")
    }
    
    func saveToPersistentStore() {
        if let employeeURL = employeeListURL {
            do {
                let encoder = PropertyListEncoder()
                let employeesData = try encoder.encode(employees)
                try employeesData.write(to: employeeURL)
            } catch {
                print("Error saving employee list data: \(error)")
            }
        }
        
        if let jobURL = jobListURL {
            do {
                let encoder = PropertyListEncoder()
                let jobData = try encoder.encode(employeeJobs)
                try jobData.write(to: jobURL)
            } catch {
                print("Error saving job list data: \(error)")
            }
        }
        
        if let logURL = logURL {
            do {
                let encoder = PropertyListEncoder()
                let logData = try encoder.encode(logText)
                try logData.write(to: logURL)
            } catch {
                print("Error saving log data: \(error)")
            }
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        if let employeeURL = employeeListURL, fileManager.fileExists(atPath: employeeURL.path) {
            do {
                let employeesData = try Data(contentsOf: employeeURL)
                let decoder = PropertyListDecoder()
                let decodedEmployees = try decoder.decode([Employee].self, from: employeesData)
                employees = decodedEmployees
            } catch {
                print("Error loading employee list data: \(error)")
            }
        }
        
        if let jobURL = jobListURL, fileManager.fileExists(atPath: jobURL.path) {
            do {
                let jobData = try Data(contentsOf: jobURL)
                let decoder = PropertyListDecoder()
                let decodedJobs = try decoder.decode([String].self, from: jobData)
                employeeJobs = decodedJobs
            } catch {
                print("Error loading job list data: \(error)")
            }
        }
        
        if let logURL = logURL, fileManager.fileExists(atPath: logURL.path) {
            do {
                let logData = try Data(contentsOf: logURL)
                let decoder = PropertyListDecoder()
                let decodedLog = try decoder.decode([String].self, from: logData)
                logText = decodedLog
            } catch {
                print("Error loading log data: \(error)")
            }
        }
    }
}
