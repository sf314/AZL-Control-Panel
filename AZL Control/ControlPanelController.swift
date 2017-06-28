//
//  ViewController.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/11/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//  Utilizes ORSSerialPort open-source library
//

// TODO: - Update UI to include NSTableView
// TODO: - Remove references to discrete UI fields
// TODO: - Add function that uses telem.data to update table data

import Cocoa

class ControlPanelController: NSViewController, ORSSerialPortDelegate {
    
    // MARK: - Data Model ******************************************************
    let parser = Parser()
    
    // MARK: - Protocol Compliance: Receive ************************************
    let serialPortManager = ORSSerialPortManager.shared()
    var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = nil
        }
    }
    
    
    // MARK: - Parsing
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) { // Here's where data is received
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            // Parse stuff and update data model
            
            print("Received (\(string as String))")
            parser.parse(string as String)
            
            if let packet = parser.getPacket() {
                print("Packet: (\(packet))")
                routePacket(packet)
                
                updateTelemetryLabels()
            }
            
            // Append to serial window
            self.serialWindow.textStorage?.mutableString.append(string as String)
            self.serialWindow.needsDisplay = true
            serialWindow.scrollToEndOfDocument(self)
            
        } else {
            print("Invalid received data")
        }
    }
    
    
    // MARK: - Protocol Compliance: Port handling ******************************
    @IBAction func connectPort(_ sender: AnyObject) {
        if let port = serialPort {
            if port.isOpen {
                port.close()
                print("Closed port")
                connectButton.title = "Connect"
            } else {
                port.open()
                port.delegate = self // BLOODY HELL
                port.baudRate = 9600
                port.numberOfStopBits = 1
                port.parity = ORSSerialPortParity(rawValue: 0)!
                port.numberOfStopBits = 1
                port.dtr = false
                port.rts = false
                connectButton.title = "Disconnect"
                print("Opened port")
            }
        }
    }
    
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        print("Serial port was removed")
        self.serialPort = nil
        //connectButton.title = "Connect"
    }
    
    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
        print("Port was opened")
    }
    
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        print("Port was closed")
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }
    
    
    
    // MARK: - UI Elements *****************************************************
    
    // Serial stuff
    @IBOutlet weak var serialWindow: NSTextView!
    @IBOutlet weak var sendButton: NSButton!
    @IBOutlet weak var commandField: NSTextField!
    @IBOutlet weak var emergencyStopButton: NSButton!
    
    @IBOutlet weak var titleBar: NSView!
    @IBOutlet weak var background: NSView!
    @IBOutlet weak var connectButton: NSButton!
    @IBOutlet weak var mapView: MapView!

    @IBOutlet weak var positionMinLabel: NSTextField!
    @IBOutlet weak var positionValueLabel: NSTextField!
    @IBOutlet weak var positionMaxLabel: NSTextField!
    
    @IBOutlet weak var velMinlabel: NSTextField!
    @IBOutlet weak var velValueLabel: NSTextField!
    @IBOutlet weak var velMaxLabel: NSTextField!
    
    @IBOutlet weak var accelMinLabel: NSTextField!
    @IBOutlet weak var accelValueLabel: NSTextField!
    @IBOutlet weak var accelMaxLabel: NSTextField!
    
    @IBOutlet weak var temp1MinLabel: NSTextField!
    @IBOutlet weak var temp1ValueLabel: NSTextField!
    @IBOutlet weak var temp1MaxLabel: NSTextField!
    
    @IBOutlet weak var temp2MinLabel: NSTextField!
    @IBOutlet weak var temp2ValueLabel: NSTextField!
    @IBOutlet weak var temp2MaxLabel: NSTextField!
    
    @IBOutlet weak var temp3MinLabel: NSTextField!
    @IBOutlet weak var temp3ValueLabel: NSTextField!
    @IBOutlet weak var temp3MaxLabel: NSTextField!
    
    @IBAction func sendButton(sender: AnyObject) {
        let packet = commandField.stringValue
        if let data = packet.data(using: String.Encoding.utf8) {
            serialPort?.send(data)
            let notifyOfActivation = "Command sent (\(packet))\n"
            self.serialWindow.textStorage?.mutableString.append(notifyOfActivation)
            self.serialWindow.needsDisplay = true
            serialWindow.scrollToEndOfDocument(self)
        } else {
            let notifyOfActivation = "Invalid Data. Cannot send.\n"
            self.serialWindow.textStorage?.mutableString.append(notifyOfActivation)
            self.serialWindow.needsDisplay = true
            serialWindow.scrollToEndOfDocument(self)
        }
    }
    
    // MARK: - Update UI from telemetry ****************************************
    func updateTelemetryLabels() {
        
        // Values in table (update table using telem)
        
        // UI
        if let pos = telem.data[1]?.value {
            mapView.set(position: pos)
        }
    }
    
    func updateMinMaxLabels() {
        
    }
    

    // ********** Cocoa overrides **********************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        serialWindow.isEditable = false
        
        connectButton.title = "Connect"

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

