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
    var packet: [String] = [] // Hold formed packet
    var tempString = "" // Hold packet during formation
    
    // NOTES
    /*
     See paper in purple folder!
     */
    
    // MARK: - Parsing (for newline)
    func parse(_ raw: String) {
        let input = raw.replacingOccurrences(of: "\r", with: "") // THIS DID IT!!!!!!!
        // Check if input contains string (and therefore marks packet end)
        if input.contains("\n") {
            let stringArray = self.makeArray(from: input, by: "\n")
            // If just a newline character, ignore.
            if input == "\n" {return}
            
            // Look at first and last character for newlines
            if firstCharacter(of: input) != "\n" && input.characters.last! != "\n" {        // DD
                // Add first and stage for return (and clear temp)
                tempString += stringArray[0]
                packet.append(tempString)
                tempString = ""
                
                // Add all the middle ones (safely check size of array, can break early)
                if stringArray.count == 2 {
                    // Just add that last one to temp
                    tempString += stringArray[1]
                }
                for index in 1..<stringArray.count - 1 {
                    packet.append(stringArray[index]) // Does this work for array size 2?
                }
                
                // Add the last one to temp string
                tempString = stringArray[stringArray.count - 1]
                
            } else if firstCharacter(of: input) == "\n" && input.characters.last! != "\n" { // ND
                // First char is newline. Stage what's currently in temp
                packet.append(tempString)
                tempString = ""
                
                // Add all the ones except last (array starts at first data)
                for index in 0..<stringArray.count - 1 {
                    packet.append(stringArray[index])
                }
                
                // Append last one to temp
                tempString = stringArray[stringArray.count - 1]
                
            } else if firstCharacter(of: input) != "\n" && input.characters.last! == "\n" { // DN
                // Add first to temp and stage for return
                tempString += stringArray[0]
                packet.append(tempString)
                tempString = ""
                
                // Add everything else (newline was found last!)
                for index in 1..<stringArray.count {
                    packet.append(stringArray[index])
                }
                
            } else if firstCharacter(of: input) == "\n" && input.characters.last! == "\n" { // NN
                // Interesting case...
                // First character is newline. Stage what's in temp
                packet.append(tempString)
                tempString = ""
                
                // Add everything!
                for string in stringArray {
                    packet.append(string)
                }
            } else {
                print("***** Impossible case *****")
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
    func getPacket() -> [String]? {
        if isValid {
            var result: [String] = []
            
            // Remove all control characters
            for var str in packet {
                str = str.replacingOccurrences(of: " ", with: "")
                str = str.replacingOccurrences(of: "\t", with: "")
                str = str.replacingOccurrences(of: "\n", with: "")
                str = str.replacingOccurrences(of: "\r", with: "")
                
                result.append(str)
            }
            
            packet.removeAll()
            return result
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

