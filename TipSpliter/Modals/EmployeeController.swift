//
//  EmployeeController.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

class EmployeeController {
    var employees: [Employee] = []
    var employeeJobs: [String] = []
        
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
            if employee == employees[i] {
                employees[i].name = name
                employees[i].percentage = percentage
                
                for j in employeeJobs.indices {
                    if job == employeeJobs[j] {}
                    else {
                        var jobExists = false
                        for k in employees.indices {
                            if employees[i] != employees[k] && employees[i].job == employees[k].job {
                                jobExists = true
                                break
                            }
                        }
                        if !jobExists {
                            employeeJobs.remove(at: j)
                        }
                        
                        employeeJobs.append(job)
                        employeeJobs.sort(by: <)
                    }
                }
                
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
                saveToPersistentStore()
                break
            }
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
    
    func saveToPersistentStore() {
        guard let employeeURL = employeeListURL else { return }
        guard let jobURL = jobListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let employeesData = try encoder.encode(employees)
            try employeesData.write(to: employeeURL)
        } catch {
            print("Error saving employee list data: \(error)")
        }
        
        do {
            let encoder = PropertyListEncoder()
            let jobData = try encoder.encode(employeeJobs)
            try jobData.write(to: jobURL)
        } catch {
            print("Error saving job list data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let employeeURL = employeeListURL, fileManager.fileExists(atPath: employeeURL.path) else { return }
        guard let jobURL = jobListURL, fileManager.fileExists(atPath: jobURL.path) else { return }

        do {
            let employeesData = try Data(contentsOf: employeeURL)
            let decoder = PropertyListDecoder()
            let decodedEmployees = try decoder.decode([Employee].self, from: employeesData)
            employees = decodedEmployees
            
        } catch {
            print("Error loading employee list data: \(error)")
        }
        
        do {
            let jobData = try Data(contentsOf: jobURL)
            let decoder = PropertyListDecoder()
            let decodedJobs = try decoder.decode([String].self, from: jobData)
            employeeJobs = decodedJobs
            
        } catch {
            print("Error loading job list data: \(error)")
        }
    }
}
