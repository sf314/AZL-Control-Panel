//
//  DataPoint.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/13/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation

/* Data Point class
 Model data points in good way i.e. min, max, name/location
 */

class DataPoint {
    var name: String
    var value = 0.0
    var min = -100.0
    var max = 100.0
    
    init(stringName: String) {
        self.name = stringName
    }
    
    var valid: Bool {
        get {
            return value >= min && value <= max
        }
    }
    
    func description() -> String {
        return "\(name) = \(value) <\(min), \(max)>"
    }
}
