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
    
    // Visual flairs
    @IBOutlet weak var mapView: MapView!

    // Table stuff
    @IBOutlet weak var tableView: NSTableView!
    
    
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
        reloadTelemetry()
        
        // UI
        if let x = telem.data[1]?.value {
            mapView.set(position: x)
        }
    }
    
    func updateMinMaxLabels() {
        
    }
    
    // MARK: - Update Table (helper method) ************************************
    func reloadTelemetry() {
        // Set anything? No cuz it's all from telem.data
        tableView.reloadData()
    }
    

    // ********** Cocoa overrides **********************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        serialWindow.isEditable = false
        
        connectButton.title = "Connect"

        // Do any additional setup after loading the view.
        
        // Set table stuff
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - Testing!!!! Remove before flight!
//        telem.add(field: ["ID", "1", "Position"])
//        telem.add(field: ["ID", "2", "Velocity"])
//        telem.add(field: ["ID", "3", "Accel"])
//        telem.add(field: ["ID", "4", "Extra"])
//        
//        telem.add(data: ["DAT", "1", "13.5"])
//        telem.add(data: ["DAT", "2", "21.3"])
//        telem.add(data: ["DAT", "3", "1234.5"])
//        
//        reloadTelemetry()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

