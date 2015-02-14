//
//  WKSSelectedAirportShop.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/10/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation
import UIKit

class WKSSelectedAirportShop: NSObject {
    // MARK: Properties
    var image: UIImage?
    var shop: WKSAirportShop?
    lazy var items = Dictionary<String, Int!>()
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    init(imageData: UIImage?, shopData: WKSAirportShop?){
        if let imagedata: UIImage! = imageData {
            image = imagedata
        }
        if let shopdata: WKSAirportShop! = shopData {
            shop = shopdata
        }
    }

}
