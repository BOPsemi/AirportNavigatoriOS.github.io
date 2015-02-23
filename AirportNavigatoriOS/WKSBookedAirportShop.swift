//
//  WKSBookedAirportShop.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/23/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import Foundation
import CoreData

class WKSBookedAirportShop: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var uuid: String
    @NSManaged var floor: NSNumber
    @NSManaged var comment: String
    @NSManaged var airport: String
    @NSManaged var items: AnyObject
    @NSManaged var imageData: NSData

}
