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
            if stringArray.count == 1 {
                // Check if newline is first or last character
                if firstCharacter(of: input) == "\n" {
                    packet = tempString
                    tempString = stringArray[0]
                    
                    // Also check if last character is also newline
                    if input.characters.last == "\n" {
                        print("Found newline as last")
                        
                    }
                } else {
                    tempString += stringArray[0]
                    packet = tempString
                    tempString.removeAll()
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

