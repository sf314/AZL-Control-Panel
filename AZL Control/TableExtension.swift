//
//  TableExtension.swift
//  AZL Control
//
//  Created by Stephen Flores on 6/29/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation
import Cocoa

// For table view protocol compliance in the form of extensions!

// MARK: - Extension to retrieve number of rows
extension ControlPanelController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return telem.data.count
    }
}

// MARK: - Extension to fill table cells
extension ControlPanelController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        // Identifers were set in the inspector of each TableCellView
        static let SensorNameCell = "SensorNameCellID"
        static let MinCell = "MinimumCellID"
        static let ValueCell = "ValueCellID"
        static let MaxCell = "MaximumCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // This is called for every row and column to get data!
        var text = ""
        var cellIdentifier = ""
        
        // TODO: - Capture data, sort it by ID, and make it indexable
        let data = telem.orderedData()
        
        // Ensure that there's an item that exists at index 'row'
        let item = data[row] // Data at index?
        
        // Set data depending on which column is being filled
        if tableColumn == tableView.tableColumns[0] { // Names
            text = item.name
            cellIdentifier = CellIdentifiers.SensorNameCell
        } else if tableColumn == tableView.tableColumns[1] { // Min
            text = String(item.min)
            cellIdentifier = CellIdentifiers.MinCell
        } else if tableColumn == tableView.tableColumns[2] { // Value
            text = String(item.value)
            cellIdentifier = CellIdentifiers.ValueCell
        } else if tableColumn == tableView.tableColumns[3] { // Max
            text = String(item.max)
            cellIdentifier = CellIdentifiers.MaxCell
        } else {
            print("TableExtension.swift: Unexpected table column found")
        }
        
        // Create cell, set text, and return it
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        
        return nil
    }

}


// MARK: - Extension of Telemetry to get sorted .data property
extension Telemetry {
    func orderedData() -> [DataPoint] {
        // Sort data
        var arr: [DataPoint] = []
        
        for key in data.keys.sorted() {
            arr.append(data[key]!)
        }
        
        return arr
    }
}














