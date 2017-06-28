//
//  Parser.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/13/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation

/* Parser class
 Accept strings as input and, if newline is found, make data available
    Use Optional return value
 */
class Parser {
    // MARK: - Local Data
    var isValid = false
    var packet = "" // Hold formed packet
    var tempString = "" // Hold packet during formation
    
    // NOTES
    /*
     No newline:
     - simple append
     - invalid
     Has newline:
     - As first character
        - save packet and clear temp
        - add arr[0] (one element)
     - As last character
        - add arr[0] (one element)
        - save packet and clear temp
     - As middle character
        - add arr[0]
        - save packet and clear temp
        - add arr[1]
     - Final: Mark valid
     */
    
    // MARK: - Parsing (for newline)
    func parse(_ raw: String) {
        let input = raw.replacingOccurrences(of: "\r", with: "") // THIS DID IT!!!!!!!
        // Check if input contains string (and therefore marks packet end)
        if input.contains("\n") {
            let stringArray = self.makeArray(from: input, by: "\n")
            if stringArray.count == 1 {
                // Check if newline is first or last character
                if firstCharacter(of: input) == "\n" {
                    packet = tempString
                    tempString = stringArray[0]
                } else {
                    tempString += stringArray[0]
                    packet = tempString
                    tempString.removeAll()
                }
            } else if input == "\n" {
                packet = tempString
                tempString = ""
            } else {
                // Newline must be middle character
                tempString += stringArray[0]
                packet = tempString
                tempString = stringArray[1]
            }
            isValid = true
        } else {
            // Simple append
            tempString += input
            isValid = false
        }
    }
    
    // MARK: - Return packet
    // Use if let structure to check
    func getPacket() -> String? {
        if isValid {
            // Remove all control characters
            packet = packet.replacingOccurrences(of: " ", with: "")
            packet = packet.replacingOccurrences(of: "\t", with: "")
            packet = packet.replacingOccurrences(of: "\n", with: "")
            packet = packet.replacingOccurrences(of: "\r", with: "")
            return packet
        } else {
            return nil
        }
    }
    
    // MARK: - Helper funcs
    func firstCharacter(of str: String) -> String {
        return String(str[str.startIndex])
    }
    
    func makeArray(from str: String, by sep: Character) -> [String] {
        var arr = str.characters.split(separator: sep).map(String.init)
        
        // Remove bad stuff, but leave newlines
        for i in 0..<arr.count {
            arr[i] = arr[i].replacingOccurrences(of: " ", with: "")
        }
        
        return arr
    }
    
    
}
