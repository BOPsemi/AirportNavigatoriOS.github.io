//
//  WKSRecordController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/23/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class WKSRecordController: NSObject {
    // MARK: Properties
    private var appDelegate: AppDelegate!
    private var context: NSManagedObjectContext!
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    
    init(model: WKSSelectedAirportShop){
        super.init()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    }
    
    // MARK: Methods
    func createEntity(){
        
    }
}