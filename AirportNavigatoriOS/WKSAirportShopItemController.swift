//
//  WKSAirportShopItemController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/12/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class WKSAirportShopItemController: NSObject {
    
    // MARK: Private Properties
    private var uuid: String?
    private var tableView: UITableView?
    private var airportShopItemTable: WKSAirportShopItemTable?
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(shopitemTable: UITableView, shopuuid: String) {
        super.init()
        
        // set uuid
        uuid = shopuuid
        
        // set tableView
        tableView = shopitemTable
        
        // show airport shop item at tableView
        setupTableView()
    }
    
    // MARK: make access server
    private func makeAccessURL() -> String!{
        let server = WKSServerInfo.ShopItemJSONServer.rawValue
        let uuidStr = "uuid=" + uuid!
        let url = server + uuidStr
        
        return url
    }
    
    // MARK: Get airport shop item data from server
    private func setupTableView(){
        let url = makeAccessURL()
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON).responseJSON
        { (request, response, data, error) -> Void in
            let objs = JSON(data!)
            var shopitems = Dictionary<String, Int!>()
            
            let items: AnyObject = objs[0]["items"].rawValue as AnyObject
            for var i=0; i<items.count; i++ {
                let item = items[i] as String
                
                // separate item str by "-"
                let args: [String] = item.componentsSeparatedByString("-")
                
                // str
                let itemname = args[0]
                let itemprice = args[1].toInt()
                
                // append item to dictionary
                shopitems[itemname] = itemprice
            }
            
            // update tableView
            self.airportShopItemTable = WKSAirportShopItemTable(itemlist: shopitems)
            self.tableView?.delegate = self.airportShopItemTable
            self.tableView?.dataSource = self.airportShopItemTable
            self.tableView?.reloadData()
            
            // post shopitems to notification center
            NSNotificationCenter.defaultCenter().postNotificationName(
                WKSNotificationInfo.AirportShopItemlist.rawValue,
                object: shopitems)
        }
    }
}