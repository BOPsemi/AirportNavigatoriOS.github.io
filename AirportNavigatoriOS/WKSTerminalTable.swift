//
//  WKSTerminalTable.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/8/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSTableView: UITableView,
                    UITableViewDataSource,
                    UITableViewDelegate{
    // MARK: Properties
    private var terminal: WKSAirportTerminal?
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(terminals data: WKSAirportTerminal!){
        super.init()
        terminal = data
    }
    
    // tableView delegate and data source
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfTerminals = terminal?.list.count
        
        return numberOfTerminals!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // define tableView cell
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        // setup text label
        let terminalName = terminal?.list[indexPath.row]
        cell.textLabel?.text = terminalName
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // pickup the selected terminal from terminal list
        let selectedTerminal: String? = terminal?.list[indexPath.row]
        
        // deselect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // post the selected terminal to notification center
        NSNotificationCenter.defaultCenter().postNotificationName(WKSNotificationInfo.TerminalTable.rawValue, object: selectedTerminal)
    }
}