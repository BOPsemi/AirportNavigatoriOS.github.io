//
//  WKSBookedAirportShopTable.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/25/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSBookedAirportShopTable: UITableView,
                                UITableViewDataSource,
                                UITableViewDelegate {
    // MARK: Properties
    private var items = [WKSBookedAirportShop]()
    
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
    init(airportshops: [WKSBookedAirportShop]) {
        super.init()
        
        // initialize item list
        items = airportshops
    }
    
    // MARK: Floor String Closure
    var floorStr = {(floorNumber: Int) -> String in
        var floorName = ["BF", "1F", "2F", "3F", "4F", "5F"]
        return floorName[floorNumber]
    }
    
    
    // MARK: tableView delegate and datasource
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // define cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        // asign tableView cell view
        let imageView = cell.viewWithTag(WKSBookedTableCell.ImageView.rawValue) as UIImageView
        let nameLabel = cell.viewWithTag(WKSBookedTableCell.ShopName.rawValue) as UILabel
        let airportLabel = cell.viewWithTag(WKSBookedTableCell.AirportName.rawValue) as UILabel
        let floorLabel = cell.viewWithTag(WKSBookedTableCell.Floor.rawValue) as UILabel
        setupViewLayout(imageView)
        setupViewLayout(nameLabel)
        
        // view setup
        imageView.image = UIImage(data: items[indexPath.row].imageData)
        nameLabel.text = items[indexPath.row].name
        airportLabel.text = items[indexPath.row].airport
        floorLabel.text = "Floor:" + floorStr(Int(items[indexPath.row].floor))
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // performance
        if editingStyle == .Delete {
            // remove object
            items.removeAtIndex(indexPath.row)
            
            // update view
            tableView.reloadData()
        }
        
        
    }
    
}