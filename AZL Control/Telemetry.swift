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
 Infinitely extensible fields (dictionary used)
 Can add new data points and point IDs
 Can update a point based on ID
 Can update limits of a point based on ID
 
 Expected format of different telemetry types:
 ID: "ID, 1, Position"
 DAT: "DAT, 1, 32.33"
 LIM: "LIM, 1, 0, 1650"
 */

class Telemetry {
    
    // MARK: - Data dictionary
    var data: [Int: DataPoint] = [:] // ID is key
    
    // MARK: - Add new telemetry field ("ID")
    func add(field packet: [String]) {
        let id: Int
        let name: String
        
        guard packet.count == 3  else {
            print("Telemetry.add(field:_): ERROR: not 3 elements in ID packet")
            return
        }
        
        // Unpack id and field name (safely!)
        if let val = Int(packet[1]) { id = val }
        else {
            print("Telmetry.add(field:_): ERROR: Cannot unpack ID")
            return
        }
        
        name = packet[2]
        
        // Create new entry in data dictionary (uses subscript syntax)
        data[id] = DataPoint(stringName: name)
        
        // Test succeeded
    }
    
    // MARK: - Data parsing ("DAT")
    func add(data: [String]) {
        let id: Int
        let value: Double
        
        // Be safe
        guard data.count == 3 else {
            print("Telemetry.add(data:_): ERROR: not 3 elements in dat packet")
            return
        }
        
        // Unpack point ID and data value
        if let x = Int(data[1]) { id = x }
        else {
            print("Telemetry.add(data:_): ERROR: Cannot unpack ID")
            return
        }
        
        if let x = Double(data[2]) { value = x }
        else {
            print("Telemetry.add(data:_): ERROR: Cannot unpack data value")
            return
        }
        
        // Update value of point in array
        self.data[id]?.value = value
        
        // Test succeeded
    }
    
    // MARK: - Update upper/lower bounds ("LIM")
    func updateBounds(data: [String]) {
        let id: Int
        let lowerBound: Double
        let upperBound: Double
        
        // Be safe
        guard data.count == 4 else {
            print("Telemetry.updateBounds(data:_): ERROR: not 4 elements")
            return
        }
        
        // Unpack id and other data (safely!)
        if let x = Int(data[1]) { id = x }
        else {
            print("Telemetry.add(data:_): ERROR: Cannot unpack ID")
            return
        }
        
        if let x = Double(data[2]) { lowerBound = x }
        else {
            print("Telemetry.add(data:_): ERROR: Cannot unpack lower bound")
            return
        }
        
        if let x = Double(data[3]) { upperBound = x }
        else {
            print("Telemetry.add(data:_): ERROR: Cannot unpack upper bound")
            return
        }
        
        // Update bounds using 
        self.data[id]?.min = lowerBound
        self.data[id]?.max = upperBound
        
        // Awesome!
    }
    
    // MARK: - Helper functions
}

// Global
var telem = Telemetry()
