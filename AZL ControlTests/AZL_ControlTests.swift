//
//  AZL_ControlTests.swift
//  AZL ControlTests
//
//  Created by Stephen Flores on 6/11/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

let actualData = ["Welco", "me to the simul", "ator\r\nEntering ", "stable state...\r", "\n", "Pre", "ss \'x\' to load ", "pod\r\n", "Push start", " (\'s\') to begin", "\r\nTELEM, 0.00, ", "0.00, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 0.00, 0.0", "6, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 0.03, 0.50,", " 9.80, 13.50, 3", ".14, 2.65\r\nTELE", "M, 0.09, 0.95, 9", ".80, 13.50, 3.1", "4, 2.65\r\nTELEM, ", "0.16, 1.40, 9.8", "0, 13.50, 3.14,", " 2.65\r\nTELEM, 0.", "25, 1.84, 9.80,", " 13.50, 3.14, 2", ".65\r\nTELEM, 0.37", ", 2.29, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 0.51, ", "2.74, 9.80, 13.", "50, 3.14, 2.65\r\n", "TELEM, 0.66, 3.", "19, 9.80, 13.50", ", 3.14, 2.65\r\nTE", "LEM, 0.84, 3.65", ", 9.80, 13.50, ", "3.14, 2.65\r\nTELE", "M, 1.04, 4.10, ", "9.80, 13.50, 3.1", "4, 2.65\r\nTELEM,", " 1.26, 4.55, 9.", "80, 13.50, 3.14,", " 2.65\r\nTELEM, 1", ".50, 4.99, 9.80", ", 13.50, 3.14, 2", ".65\r\nTELEM, 1.7", "6, 5.44, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 2.04,", " 5.89, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 2.33, 6", ".33, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 2.65, 6.78", ", 9.80, 13.50, ", "3.14, 2.65\r\nTEL", "EM, 3.00, 7.23, ", "9.80, 13.50, 3.", "14, 2.65\r\nTELEM", ", 3.35, 7.67, 9.", "80, 13.50, 3.14", ", 2.65\r\nTELEM, 3", ".74, 8.12, 9.80", ", 13.50, 3.14, ", "2.65\r\nTELEM, 4.1", "4, 8.57, 9.80, ", "13.50, 3.14, 2.", "65\r\nTELEM, 4.56,", " 9.02, 9.80, 13", ".50, 3.14, 2.65\r", "\nTELEM, 5.00, 9", ".47, 9.80, 13.5", "0, 3.14, 2.65\r\nT", "ELEM, 5.48, 9.9", "3, 9.80, 13.50,", " 3.14, 2.65\r\nTEL", "EM, 5.97, 10.38", ", 9.80, 13.50, 3", ".14, 2.65\r\nTELE", "M, 6.48, 10.83,", " 9.80, 13.50, 3.", "14, 2.65\r\nTELEM", ", 7.02, 11.29, ", "9.80, 13.50, 3.1", "4, 2.65\r\nTELEM,", " 7.58, 11.75, 9.", "80, 13.50, 3.14", ", 2.65\r\nTELEM, ", "8.15, 12.20, 9.8", "0, 13.50, 3.14,", " 2.65\r\nTELEM, 8", ".76, 12.66, 9.80", ", 13.50, 3.14, ", "2.65\r\nTELEM, 9.", "39, 13.12, 9.80,", " 13.50, 3.14, 2", ".65\r\nTELEM, 10.0", "2, 13.57, 9.80,", " 13.50, 3.14, 2", ".65\r\nTELEM, 10.7", "1, 14.04, 9.80,", " 13.50, 3.14, 2", ".65\r\nTELEM, 11.4", "3, 14.52, 9.80,", " 13.50, 3.14, 2.", "65\r\nTELEM, 12.1", "6, 14.99, 9.80,", " 13.50, 3.14, 2.", "65\r\nTELEM, 12.9", "0, 15.45, 9.80,", " 13.50, 3.14, 2.", "65\r\nTELEM, 13.6", "7, 15.92, 9.80, ", "13.50, 3.14, 2.", "65\r\nTELEM, 14.4", "7, 16.40, 9.80, ", "13.50, 3.14, 2.", "65\r\nTELEM, 15.2", "7, 16.86, 9.80, ", "13.50, 3.14, 2.", "65\r\nTELEM, 16.12", ", 17.33, 9.80, ", "13.50, 3.14, 2.", "65\r\nTELEM, 16.98", ", 17.80, 9.80, ", "13.50, 3.14, 2.", "65\r\nTELEM, 17.87", ", 18.27, 9.80, ", "13.50, 3.14, 2.6", "5\r\nTELEM, 18.78", ", 18.74, 9.80, ", "13.50, 3.14, 2.6", "5\r\nTELEM, 19.72", ", 19.21, 9.80, ", "13.50, 3.14, 2.6", "5\r\nTELEM, 20.67", ", 19.68, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 21.65", ", 20.15, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 22.63", ", 20.61, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 23.65", ", 21.08, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 24.70,", " 21.55, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 25.74,", " 22.01, 9.80, 1", "3.50, 3.14, 2.6", "5\r\nTELEM, 26.86,", " 22.49, 9.80, 1", "3.50, 3.14, 2.65", "\r\nTELEM, 27.97,", " 22.96, 9.80, 1", "3.50, 3.14, 2.65", "\r\nTELEM, 29.11,", " 23.43, 9.80, 1", "3.50, 3.14, 2.65", "\r\nTELEM, 30.24,", " 23.89, 9.80, 13", ".50, 3.14, 2.65", "\r\nTELEM, 31.42,", " 24.36, 9.80, 13", ".50, 3.14, 2.65", "\r\nTELEM, 32.62,", " 24.83, 9.80, 13", ".50, 3.14, 2.65", "\r\nTELEM, 33.82, ", "25.29, 9.80, 13", ".50, 3.14, 2.65", "\r\nTELEM, 35.07, ", "25.76, 9.80, 13", ".50, 3.14, 2.65", "\r\nTELEM, 36.37, ", "26.24, 9.80, 13", ".50, 3.14, 2.65\r", "\nTELEM, 37.66, ", "26.71, 9.80, 13", ".50, 3.14, 2.65\r", "\nTELEM, 38.95, ", "27.18, 9.80, 13", ".50, 3.14, 2.65\r", "\nTELEM, 40.29, ", "27.65, 9.80, 13", ".50, 3.14, 2.65\r", "\nTELEM, 41.65, ", "28.12, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 43.00, ", "28.58, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 44.41, ", "29.05, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 45.84, 2", "9.52, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 47.32, 3", "0.00, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 48.76, 3", "0.46, 9.80, 13.", "50, 3.14, 2.65\r\n", "TELEM, 50.26, 3", "0.93, 9.80, 13.", "50, 3.14, 2.65\r\n", "TELEM, 51.78, 3", "1.40, 9.80, 13.", "50, 3.14, 2.65\r\n", "TELEM, 53.28, 3", "1.86, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 54.85, 3", "2.33, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 56.43, 3", "2.80, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 58.04, 33", ".27, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 59.64, 33", ".73, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 61.33, 34", ".21, 9.80, 13.5", "0, 3.14, 2.65\r\nT", "ELEM, 63.00, 34", ".68, 9.80, 13.5", "0, 3.14, 2.65\r\nT", "ELEM, 64.70, 35", ".15, 9.80, 13.5", "0, 3.14, 2.65\r\nT", "ELEM, 66.39, 35", ".61, 9.80, 13.5", "0, 3.14, 2.65\r\nT", "ELEM, 68.13, 36", ".08, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 69.89, 36", ".55, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 71.65, 37", ".01, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 73.46, 37.", "49, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 75.33, 37.", "97, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 77.18, 38.", "44, 9.80, 13.50", ", 3.14, 2.65\r\nTE", "LEM, 79.02, 38.", "90, 9.80, 13.50", ", 3.14, 2.65\r\nTE", "LEM, 80.92, 39.", "37, 9.80, 13.50", ", 3.14, 2.65\r\nTE", "LEM, 82.85, 39.", "84, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 84.75, 40.", "30, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 86.72, 40.", "77, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 88.71, 41.2", "4, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 90.77, 41.7", "2, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 92.76, 42.1", "8, 9.80, 13.50,", " 3.14, 2.65\r\nTEL", "EM, 94.82, 42.6", "5, 9.80, 13.50,", " 3.14, 2.65\r\nTEL", "EM, 96.90, 43.1", "2, 9.80, 13.50,", " 3.14, 2.65\r\nTEL", "EM, 98.96, 43.5", "8, 9.80, 13.50, ", "3.14, 2.65\r\nTEL", "EM, 101.08, 44.", "05, 9.80, 13.50,", " 3.14, 2.65\r\nTE", "LEM, 103.28, 44", ".53, 9.80, 13.50", ", 3.14, 2.65\r\nT", "ELEM, 105.50, 4", "5.01, 9.80, 13.5", "0, 3.14, 2.65\r\n", "TELEM, 107.74, 4", "5.49, 9.80, 13.", "50, 3.14, 2.65\r", "\nTELEM, 110.00, ", "45.97, 9.80, 13", ".50, 3.14, 2.65\r", "\nTELEM, 112.29,", " 46.45, 9.80, 1", "3.50, 3.14, 2.65", "\r\nTELEM, 114.60", ", 46.93, 9.80, ", "13.50, 3.14, 2.6", "5\r\nTELEM, 116.8", "9, 47.40, 9.80,", " 13.50, 3.14, 2.", "65\r\nTELEM, 119.", "25, 47.88, 9.80,", " 13.50, 3.14, 2", ".65\r\nTELEM, 121", ".63, 48.36, 9.80", ", 13.50, 3.14, ", "2.65\r\nTELEM, 12", "4.08, 48.85, 9.8", "0, 13.50, 3.14,", " 2.65\r\nTELEM, 12", "6.46, 49.32, 9.", "80, 13.50, 3.14", ", 2.65\r\nTELEM, 1", "28.91, 49.80, 9", ".80, 13.50, 3.1", "4, 2.65\r\nTELEM, ", "131.39, 50.28, ", "9.80, 13.50, 3.1", "4, 2.65\r\nTELEM,", " 133.84, 50.75,", " 9.80, 13.50, 3.", "14, 2.65\r\nTELEM", ", 136.36, 51.23", ", 9.80, 13.50, 3", ".14, 2.65\r\nTELE", "M, 138.90, 51.71", ", 9.80, 13.50, ", "3.14, 2.65\r\nTEL"]

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
    
    func testParser_goodData() {
        // Create good fake data to parse
        let fakeData = actualData
        let parser = Parser()
        
        // Make sure  parser works
        for data in fakeData {
            let arr = parser.makeArray(from: data, by: "\n")
            XCTAssert(arr[0].contains("\n") == false)
            print(arr)
        }
        
        // Parse all data and check for output on newline
        for data in fakeData {
            parser.parse(data)
            
            if let packet = parser.getPacket() {
                print("Good: (\(packet))")
                XCTAssert(packet.contains("\n") == false)
                XCTAssert(packet.contains(" ") == false)
                XCTAssert(packet != "")
            }
            
        }
    }
    
    func testParser_badData() {
        // Create bad data to parse
        let fakeData = ["", "", "", "", "", "", "", "", ""]
        
        // Parse all data and ensure bad data is handled expectedly
        let parser = Parser()
        for data in fakeData {
            parser.parse(data)
            
            if let packet = parser.getPacket() {
                print("Good: (\(packet)))")
                XCTAssert(packet.contains("\n") == false)
                XCTAssert(packet.contains(" ") == false)
                XCTAssert(packet != "")
            }
        }
    }
    
    func testDataPoint() {
        let pt = DataPoint(lowerBound: 0, upperBound: 10)
        
        // In bounds
        pt.value = 5
        XCTAssert(pt.valid == true)
        
        // Above bounds
        pt.value = 12
        XCTAssert(pt.valid == false)
        
        // Below bounds
        pt.value = -12
        XCTAssert(pt.valid == false)
        
        // On bounds
        pt.value = 0
        XCTAssert(pt.valid == true)
        pt.value = 10
        XCTAssert(pt.valid == true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
