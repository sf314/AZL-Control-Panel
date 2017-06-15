//
//  MapView.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/14/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics

/* Map View class
 Create means of displaying minimap using position information
 Maybe different states trigger different colours?
 */

@IBDesignable
class MapView: NSView {
    
    // MARK: - Data model
    var currentPosition = 0.0
    let endOfTrack = 1609.0 // store the end of the thing
    
    func set(position: Double) {
        currentPosition = position
        updateDisplay()
    }
    
    // MARK: - Custom drawing
    override func draw(_ rect: CGRect) {
        // Capture necessary variables
        let mapHeight = Double(rect.height)
        let mapWidth = Double(rect.width)
        let mapRect = NSRect(x: 0, y: 0, width: mapWidth, height: mapHeight)
        let mapBezier = NSBezierPath(rect: mapRect)
        
        // Draw background colour
        foregroundColour.set()
        mapBezier.fill()
        
        // Draw border
        borderColour.set()
        mapBezier.lineWidth = 5
        mapBezier.stroke()
        
        // Draw extraneous details here
        
        // Draw pod at position
        let xPosition = map(pos: currentPosition, to: mapWidth - 7)
        let podRect = NSRect(x: xPosition, y: 10, width: 7, height: mapHeight - 20)
        let podPath = NSBezierPath(rect: podRect)
        
        dataPointColour.set()
        podPath.fill()
        
    }
    
    // MARK: - Helper functions
    func updateDisplay() {
        self.setNeedsDisplay(self.bounds)
    }
    
    func map(pos: Double, to max: Double) -> Double {
        // Map position info to within a set upper bound
        return (max * pos) / endOfTrack
    }
}
