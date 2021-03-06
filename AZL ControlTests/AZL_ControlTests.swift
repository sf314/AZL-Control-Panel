//
//  AZL_ControlTests.swift
//  AZL ControlTests
//
//  Created by Stephen Flores on 6/11/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import XCTest
@testable import AZL_Control

class AZL_ControlTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    // MARK: - Test Telemetry class
    func testTelemAddField() {
        // Create telem and add new fields
        let tel = Telemetry()
        tel.add(field: ["ID", "1", "Position"])
        tel.add(field: ["ID", "2", "Velocity"])
        tel.add(field: ["ID", "3", "Accel"])
        
        // Check that new fields are added in dictionary
        XCTAssert(tel.data[1]?.name == "Position")
        XCTAssert(tel.data[3]?.name == "Accel")
        XCTAssert(tel.data.count == 3)
        
        // Print them for certainty
        for (id, point) in tel.data {
            print("\(id): \(point.description())")
        }
    }
    
    func testTelemAddData() {
        // Create telem and add two fields
        let tel = Telemetry()
        tel.add(field: ["ID", "1", "X"])
        tel.add(field: ["ID", "2", "Y"])
        
        // Update data to fields
        tel.add(data: ["DAT", "1", "13.5"])
        tel.add(data: ["DAT", "2", "21.3"])
        
        // Check data values
        XCTAssert(tel.data[1]?.value == 13.5)
        XCTAssert(tel.data[2]?.value == 21.3)
        
        // Print for verification
        for (id, point) in tel.data {
            print("\(id): \(point.description())")
        }
    }
    
    
    // MARK: - Test Parser class
    func testParser_goodData() {
        // Create good fake data to parse
        let goodData = ["0.97\nDAT, 1, 0.", "03\nDAT, 2, 0.4", "7\nDAT, 3, 9.80", "\nDAT, 4, 2.43\n", "DAT, 5, 0.59\nD"]
        let parser = Parser()
        
        // Make sure  parser works
        for data in goodData {
            parser.parse(data)
            
            if let packet = parser.getPacket() {
                print("Good: (\(packet))")
                XCTAssert(packet.contains("\n") == false)
                XCTAssert(packet.contains(" ") == false)
                XCTAssert(packet != "")
            }
        }
        
        // Parse all data and check for output on newline

    }
    
    func testParser_badData() {
        // Create bad data to parse
        
        let badData = ["0.97\nDAT, 1, \n0.", "03\nDAT, 2, \n0.4", "7\nDAT, 3, \n9.80", "\nDAT, 4, \n2.43\n", "DAT, 5, \n0.59\nD"]
        let parser = Parser()
        
        // Make sure  parser works
        for data in badData {
            parser.parse(data)
            
            if let packet = parser.getPacket() {
                print("Good: (\(packet))")
                XCTAssert(packet.contains("\n") == false)
                XCTAssert(packet.contains(" ") == false)
                XCTAssert(packet != "")
            }
        }
        
        // Parse all data and ensure bad data is handled expectedly

    }
    
    // MARK: - Test DataPoint class
    func testDataPoint() {
        
        
    }
    
    // MARK: - Other tests
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
