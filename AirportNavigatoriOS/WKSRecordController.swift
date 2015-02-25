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
    private var context: NSManagedObjectContext?
    private var entityname: String?
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    
    init(entityName: String) {
        super.init()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        context = appDelegate.managedObjectContext
        entityname = entityName
        
    }
    
    // MARK: execute fetch request
    private func executeFetch(fetchrequest: NSFetchRequest) -> [WKSBookedAirportShop]?{
        var stack = [WKSBookedAirportShop]()
        var error: NSError? = nil
        
        if var objs = context?.executeFetchRequest(fetchrequest, error: &error) {
            for obj in objs {
                let object = obj as WKSBookedAirportShop
                
                // stack find object
                stack.append(object)
            }
        }
        
        return stack
    }
    
    // MARK: Create Entity
    func createEntity() -> WKSBookedAirportShop? {
        // entity
        var entity: WKSBookedAirportShop?
        
        
        if let context = self.context {
            
            // make managed object
            let managedObject: AnyObject
                = NSEntityDescription.insertNewObjectForEntityForName(
                    entityname!, inManagedObjectContext:
                    context) as AnyObject
            
            // make entity
            entity = managedObject as? WKSBookedAirportShop
        }
        
        return entity
    }
    
    // MARK: fetch all objects
    func findAllEntity() -> [WKSBookedAirportShop] {
        // stack of fetched objects
        var findObjects = [WKSBookedAirportShop]()
        
        // fetch
        if let context = self.context {
            let entityDescription = NSEntityDescription.entityForName(entityname!, inManagedObjectContext: context)
            
            // make request
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            // execute fetch objects
            findObjects = executeFetch(request)!
        }
        
        return findObjects
    }
    
    // MARK: fetch objects by keyword
    func findEntity(keyword: String?) -> [WKSBookedAirportShop]{
        
        // stack of fetched objects
        var findObjects = [WKSBookedAirportShop]()
        
        // fetch
        if let context = self.context {
            let entityDescription = NSEntityDescription.entityForName(entityname!, inManagedObjectContext: context)
            
            // make request
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            // make prediction phrase
            request.predicate = NSPredicate(format: "name=%@", keyword!)
            
            // execute fetch objects
            findObjects = executeFetch(request)!
        }
        
        return findObjects
    }
    
    // MARK: delete object
    func deleteEntity(keyword: String?){
        // fetch
        if let context = self.context {
            let entityDescription = NSEntityDescription.entityForName(entityname!, inManagedObjectContext: context)
            
            // make request
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            // make prediction phrase
            request.predicate = NSPredicate(format: "name=%@", keyword!)
            
            // execute fetch objects
            var error: NSError? = nil
            if var objs = context.executeFetchRequest(request, error: &error) {
                for obj in objs {
                    let entity = obj as WKSBookedAirportShop
                    context.deleteObject(entity)
                }
            }
        }
    }

    // MARK: save context
    func saveEntity(){
        appDelegate.saveContext()
    }
}