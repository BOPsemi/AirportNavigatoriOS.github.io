//
//  WKSAirportTerminal.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/5/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation

class WKSAirportTerminal: NSObject {
    // MARK: Properties
    var list = [String]()
    var floorNumber:Int = 5
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(terminal list:[String], floors:Int){
        super.init()
        self.list = list
        self.floorNumber = floors
    }
}
