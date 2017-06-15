//
//  Telemetry.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/13/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation

/* Telemetry 
 Model pod telemetry
 Add as necessary
 */

class Telemetry {
    let expectedPacketSize = 7 // Including packet ID
    
    // MARK: - Data fields
    var position = DataPoint(lowerBound: 0, upperBound: 1700)
    var velocity = DataPoint(lowerBound: 0, upperBound: 300)
    var acceleration = DataPoint(lowerBound: -54, upperBound: 100)
    var temp1 = DataPoint(lowerBound: 0, upperBound: 50)
    var temp2 = DataPoint(lowerBound: 0, upperBound: 50)
    var temp3 = DataPoint(lowerBound: 0, upperBound: 50)
    
    // MARK: - Packet parsing
    func add(data: [String]) {
        // Be safe!
        guard data.count >= expectedPacketSize else {
            print("Invalid packet count. Expected \(self.expectedPacketSize), received \(data.count)")
            return
        }
        
        // Guaranteed to have 6 telem fields below this line
        print("Hey! data[1] = \(data[1])")
        
        if let x = Double(data[1]) {self.position.value = x} else {print("Failed on \(data[1])") }
        if let x = Double(data[2]) {self.velocity.value = x}
        if let x = Double(data[3]) {self.acceleration.value = x}
        if let x = Double(data[4]) {self.temp1.value = x}
        if let x = Double(data[5]) {self.temp2.value = x}
        if let x = Double(data[6]) {self.temp3.value = x}
    }
    
    func setBounds(data: [String]) {
        // Be safe!
        guard data.count >= 2 * expectedPacketSize else {
            print("Invalid packet count. Expected \(self.expectedPacketSize), received \(data.count)")
            return
        }
        
        // Guaranteed to be settable from here!
        if let x = Double(data[1]), let y = Double(data[2]) {
            position.min = x
            position.max = y
        }
        
        if let x = Double(data[3]), let y = Double(data[4]) {
            velocity.min = x
            velocity.max = y
        }
        
        if let x = Double(data[5]), let y = Double(data[6]) {
            acceleration.min = x
            acceleration.max = y
        }
        
        if let x = Double(data[7]), let y = Double(data[8]) {
            temp1.min = x
            temp1.max = y
        }
        
        if let x = Double(data[9]), let y = Double(data[10]) {
            temp2.min = x
            temp2.max = y
        }
        
        if let x = Double(data[11]), let y = Double(data[12]) {
            temp3.min = x
            temp3.max = y
        }
        
    }
    
    // MARK: - Helper functions
}

// Global
var telem = Telemetry()
