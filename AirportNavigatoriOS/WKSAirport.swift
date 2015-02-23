//
//  WKSAirport.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/5/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation

class WKSAirport: NSObject {
    // MARK: Properties
    var IATAcode:String?
    var ICAOcode:String?
    var AirportJpName:String?
    var AirportEnName:String?
    var Country:String?
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(iata:String!, icao:String!, jpName:String!, enName:String!){
        self.IATAcode = iata
        self.ICAOcode = icao
        self.AirportJpName = jpName
        self.AirportEnName = enName
        self.Country = "jp"
    }
}
