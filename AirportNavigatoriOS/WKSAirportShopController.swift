//
//  WKSAirportShopController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/8/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WKSAirportShopController: NSObject {
    // MARK: public properties
    var collectionView: UICollectionView!
    
    // MARK: private properties
    private var shopCollection: WKSShopCollection?
    
    // MARK: setup notification center
    private func addNotificationCenter(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "setupShopCollection:",
            name: WKSNotificationInfo.AirportShopInf.rawValue,
            object: nil)
    }
    
    // MARK: filter
    
    // MARK: setup Airport shop
    func setupShopCollection(notification: NSNotification?){
        var iatacode: String!
        var terminal: String!
        
        // setup access information
        if let airport: WKSAirport! = notification?.object as? WKSAirport {
            iatacode = airport.IATAcode as String!
        }
        if let userInfo: Dictionary<String, String!> = notification?.userInfo as? Dictionary<String, String!>{
            terminal = userInfo["terminal"] as String!
        }
        
        // make access url
        let url = WKSServerInfo.ShopJSONServer.rawValue + "iatacode=" + iatacode + "&" + "terminal=" + terminal
        
        // get shop data from server
        obtainShopJSONData(url)
        
    }
    
 
    // MARK: JSON data handler
    private func deserializeJSONdata(data: AnyObject?) -> [WKSAirportShop]{
        let objs = JSON(data!)
        var airportShops = [WKSAirportShop]()
        
        for var i=0; i<objs.count; i++ {
            var shop = WKSAirportShop()
            
            // extract properties
            shop.name = objs[i]["name"].string! as String!
            shop.floor = objs[i]["floor"].int! as Int!
            shop.comment = objs[i]["comment"].string! as String!
            shop.uuid = objs[i]["uuid"].string! as String!
            
            // extract access urls from imageurls array
            let imageurls: AnyObject = objs[i]["imageurls"].rawValue as AnyObject!
            let urlcount:Int = imageurls.count
            
            for var j=0; j<urlcount; j++ {
                let accessurl = imageurls[j] as String!
                let url = WKSServerInfo.ShopImageDataServer.rawValue + "fileName=" + accessurl
                
                shop.imageurls.append(url)
            }
            
            // stack airport shop objects
            airportShops.append(shop)
        }
        
        // return airportShops array
        return airportShops
    }
    
    // MARK: obtain data from server
    private func obtainShopJSONData(url: String!){
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON)
        .responseJSON { (request, response, data, error) -> Void in

            // deserialize JSON data
            let airportShops = self.deserializeJSONdata(data)
            
            // setup collection view
            self.shopCollection = WKSShopCollection(shops: airportShops)
            self.collectionView.delegate = self.shopCollection
            self.collectionView.dataSource = self.shopCollection
            
            return
        }
    }
    
    // MARK: Initializer
    override init() {
        super.init()
        
        // setup notification center
        addNotificationCenter()
        
    }
    
}