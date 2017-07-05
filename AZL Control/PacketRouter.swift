//
//  PacketRouter.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/13/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation

/* Packet Router
 Decide which structure to send the packet to, and send it
 Expected structure: [packet ID, data, data, ..., data]
 
 Expected packet types:
 ID: Provided upon startup to alert the CP of all telemetry fields. Provides
    a named string and integer ID for it. Will be stored in a telem dictionary.
 DAT: Provided during runtime to add new telemetry data. Passes the integer ID 
    of the field to be updated, as well as the data itself.
 LIM: Provided necessarily during runtime to set new max/min limits for a data
    point. Requires the integer ID of the desired telemetry field.
 */
func routePacket(_ packet: [String]) {
    // Turn it into array and switch on packet ID
    for str in packet {
        let arr = str.components(separatedBy: ",")
        let id = arr[0]
        
        switch id {
        case "ID":
            telem.add(field: arr)
        case "DAT":
            telem.add(data: arr)
        case "LIM":
            telem.updateBounds(data: arr)
        default:
            print("\troutePacket(): Invalid packet ID: (\(id))")
            break
        }
    }
}
