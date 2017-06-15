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
    var value = 0.0
    var min = 0.0
    var max = 0.0
    
    init(lowerBound min: Double, upperBound max: Double) {
        self.min = min
        self.max = max
    }
    
    var valid: Bool {
        get {
            return value >= min && value <= max
        }
    }
}
