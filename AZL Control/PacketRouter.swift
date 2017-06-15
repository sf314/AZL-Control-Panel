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
 */
func routePacket(_ packet: String) {
    // Turn it into array and switch on packet ID
    let arr = packet.components(separatedBy: ",")
    
    switch arr[0] {
        case "TELEM":
            print("\tIn routePacket()")
            telem.add(data: arr)
        case "LIMITS":
            telem.setBounds(data: arr)
    default:
        print("\troutePacket(): Invalid packet ID: (\(arr[0]))")
        break
    }
}
