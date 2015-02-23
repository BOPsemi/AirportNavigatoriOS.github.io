//
//  WKSAirportShop.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/8/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

protocol WKSAirportShopInterface {
    var name: String{set get}
    var floor: Int{set get}
    var comment: String{set get}
    var uuid: String{set get}
    var airportname: String{set get}
    var imageurls: [String]{set get}
}

struct WKSAirportShop: WKSAirportShopInterface {
    var name = "sample"
    var floor = 0
    var comment = "None"
    var uuid = "None"
    var airportname = "None"
    var imageurls = [String]()
}