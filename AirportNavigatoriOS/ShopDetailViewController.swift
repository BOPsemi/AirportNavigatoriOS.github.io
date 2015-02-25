//
//  ShopDetailViewController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/9/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit
import CoreData

class ShopDetailViewController: UIViewController {
    
    // MARK: Properties
    private var airportShop: WKSSelectedAirportShop?{
        didSet{
            imageView.image = airportShop?.image
            shopTitle.text = airportShop?.shop?.name
            commentTextView.text = airportShop?.shop?.comment
            
            // setup tableView
            let uuid = airportShop?.shop?.uuid
            airpotShopItemController = WKSAirportShopItemController(shopitemTable: tableView, shopuuid: uuid!)
        }
    }
    private var airpotShopItemController: WKSAirportShopItemController?
    private lazy var shopitemList = Dictionary<String, Int!>()
    private var bookmark = false
    
    // MARK: Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shopTitle: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: bookmark switch action
    @IBAction func bookmarkSwitch(sender: AnyObject) {
        let sw = sender as UISwitch
        if sw.on {
            bookmark = true
        }
    }
    
    // MARK: setup view
    private func setupView(){
        imageView.contentMode = .ScaleAspectFill
    }
    
    // MARK:  add notification center
    private func addNotificationCenter(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "setupSelectedAirportShop:",
            name: WKSNotificationInfo.AirportShopSelected.rawValue,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "fetchedShopItems:",
            name: WKSNotificationInfo.AirportShopItemlist.rawValue,
            object: nil)
    }
    
    // MARK: setup selected airport shop
    func setupSelectedAirportShop(notification: NSNotification?){
        if let shop: WKSSelectedAirportShop! = notification?.object as? WKSSelectedAirportShop {
            // setup shop model
            airportShop = shop
        }
    }
    
    // MARK: fetched airport shop item list
    func fetchedShopItems(notification: NSNotification?){
        if let itemList: Dictionary<String, Int!> = notification?.object as? Dictionary<String, Int!> {
            // setup shop list
            shopitemList = itemList
            airportShop?.items = shopitemList
        }
    }
    
    // MARK: save booked airport shop
    private func saveAirportShopInDB(model: WKSSelectedAirportShop) {
        // initialize database
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let context = appDelegate.managedObjectContext {
            let managedObject: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("WKSBookedAirportShop", inManagedObjectContext: context) as WKSBookedAirportShop
            
            // set value
            let entity = managedObject as WKSBookedAirportShop
            let imageData = UIImageJPEGRepresentation(model.image!, 1.0)
            
            entity.name = model.shop!.name
            entity.uuid = model.shop!.uuid
            entity.floor = model.shop!.floor
            entity.comment = model.shop!.comment
            entity.airport = model.shop!.airportname
            entity.imageData = imageData
            entity.items = model.items
            
            // save data 
            appDelegate.saveContext()
        }
    }
    
    // MARK: did clicked Close Button
    @IBAction func didClickedCloseButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            // bookmark switch-on
            if self.bookmark {
                // setup record object
                let record = WKSRecordController(entityName: "WKSBookedAirportShop")
                let objs = record.findEntity(self.airportShop?.shop?.name)
                                
                if objs.count == 0 { // not exist in database
                    
                    // create new entity
                    let entity = record.createEntity()
                    let imageData = UIImageJPEGRepresentation(self.airportShop?.image, 1.0)
                    
                    entity?.name = self.airportShop!.shop!.name
                    entity?.uuid = self.airportShop!.shop!.uuid
                    entity?.floor = self.airportShop!.shop!.floor
                    entity?.comment = self.airportShop!.shop!.comment
                    entity?.airport = self.airportShop!.shop!.airportname
                    entity?.imageData = imageData
                    entity?.items = self.airportShop!.items
                    
                    if let obj: WKSBookedAirportShop! = entity {
                        // record.saveEntity()
                        println("Saving")
                    }
                }
            }
        })
    }
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view
        setupView()
        
        // add notification center
        addNotificationCenter()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}