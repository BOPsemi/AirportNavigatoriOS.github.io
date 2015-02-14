//
//  WKSAirportListMaker.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/5/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation

class WKSAirportListMaker: NSObject {
    // MARK: Properties
    var list = [WKSAirport]()   // airport list
    var count:Int?          // number of list
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(plistname name: String!){
        super.init()
        
        // make airport list
        let objs = self.openAirportPlist(name: name)
        for obj in objs {
            let data = self.airpotInfo(obj)
            let airport = WKSAirport(iata: data.iata, icao: data.icao, jpName: data.jpName, enName: data.enName)
            
            self.list.append(airport)
        }
        
        self.count = self.list.count
    }
    
    // MARK: Methods/declear airport Info
    private func airpotInfo(obj:AnyObject!) ->(iata: String?, icao: String?, jpName: String?, enName: String?){
        let iata = obj.objectForKey("IATA") as String
        let icao = obj.objectForKey("ICAO") as String
        let jpName = obj.objectForKey("jpAirport") as String
        let enName = obj.objectForKey("Airport") as String
        
        return (iata,icao,jpName,enName)
    }
    
    // MARK: Methods/open Airport plist
    private func openAirportPlist(#name: String!) -> [AnyObject]{
        // variables
        var list = [AnyObject]()    // data list
        
        // open plist
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist")
        if let path: String? = path {
            // not recieved file open error
            let data = NSDictionary(contentsOfFile: path!)
            
            // make list
            list = data?.objectForKey("airportlist") as [AnyObject]
        }
        
        // return list
        return list
    }
}
