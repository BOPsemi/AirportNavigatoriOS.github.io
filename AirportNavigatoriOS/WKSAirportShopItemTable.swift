//
//  WKSAirportShopItemTable.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/12/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//


import UIKit

class WKSAirportShopItemTable: UITableView,
                            UITableViewDelegate,
                            UITableViewDataSource{
    
    
    // MARK: Properties
    private lazy var items = Dictionary<String, Int!>()
    private lazy var itemNames = [String]()
    
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
    init(itemlist: Dictionary<String, Int!>) {
        super.init()
        
        // set items
        items = itemlist
        
        // set item name array
        itemNames = Array(items.keys)
    }
    
    // MARK: tableView delegate & detasource
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        // make labels
        let itemname = itemNames[indexPath.row] as String!
        let price = items[itemname] as Int!
        
        cell.textLabel?.text = itemname
        cell.detailTextLabel?.text = "¥" + String(price)
        
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Shop Items"
    }
}