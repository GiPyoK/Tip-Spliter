//
//  Employee.swift
//  TipSpliter
//
//  Created by Gi Pyo Kim on 9/23/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

struct Employee: Equatable, Codable, Comparable {
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name == rhs.name && lhs.job == rhs.job && lhs.percentage == rhs.percentage
    }
    
    var name: String
    var job: String
    var percentage: Int
    var hasWorked: Bool
    var tip: Double
    
    init(name: String, job: String, percentage: Int) {
        self.name = name
        self.job = job
        self.percentage = percentage
        hasWorked = false
        tip = 0.0
    }
}
