//
//  WKSBookedAirportShopController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/25/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation
import UIKit

class WKSBookedAirportShopController: NSObject {
    // MARK: Properties
    private var tableView: UITableView?
    private var recordController: WKSRecordController!
    private var bookedAirportShops = [WKSBookedAirportShop]()
    private var bookedAirportShopTable: WKSBookedAirportShopTable!
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(shoptableView: UITableView){
        super.init()
        
        // tableView
        tableView = shoptableView
        
        // make list
        bookedAirportShops = makeBookedAirportShopsList()!
        
        // initialize tableView
        bookedAirportShopTable = WKSBookedAirportShopTable(airportshops: bookedAirportShops)
        tableView?.delegate = bookedAirportShopTable
        tableView?.dataSource = bookedAirportShopTable
        
    }
    
    // MARK: Fetch request
    private func makeBookedAirportShopsList() -> [WKSBookedAirportShop]? {
        let record = WKSRecordController(entityName: "WKSBookedAirportShop")
        let objs = record.findAllEntity()
        
        return objs
    }
}
