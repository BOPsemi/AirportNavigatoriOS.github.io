//
//  WKSAirportTerminalListMaker.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/5/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation

class WKSAirportTerminalListMaker: NSObject {
    // MARK: Properties
    var terminals: WKSAirportTerminal?
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(airport obj: WKSAirport) {
        super.init()
        
        let iata = obj.IATAcode!
        let listOfTerminal = self.openAirportTerminalPlist(name: "AirportTerminal", iatacode: iata)
        let count = listOfTerminal.count-2
        let list:[String] = Array(listOfTerminal[0...count])
        let floorNumber = listOfTerminal.last?.toInt()
        
        self.terminals = WKSAirportTerminal(terminal: list, floors: floorNumber!)
        
    }
    
    // MARK: Methods/open Airport plist
    private func openAirportTerminalPlist(#name:String!, iatacode:String!) -> [String] {
        // variables
        var terminal = [String]()
        
        // open plist
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist")
        if let path: String? = path {
            // make data list
            let data = NSDictionary(contentsOfFile: path!)
            if var obj = data?.objectForKey(iatacode) as? [String] {
                terminal = obj
            }
        }
        
        return terminal
    }
}
