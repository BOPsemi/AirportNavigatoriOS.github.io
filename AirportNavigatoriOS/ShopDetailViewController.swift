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
    
    // MARK: Search data
    private func fetchAirportShopInDB(model: WKSSelectedAirportShop) {
        // initialize database
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let context = appDelegate.managedObjectContext {
            let entityDescription = NSEntityDescription.entityForName("WKSBookedAirportShop", inManagedObjectContext: context)
            
            // make request
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            // make prediction phrase
            let shopname = model.shop!.name
            let pred = NSPredicate(format: "name=%@", shopname)
            request.predicate = pred
            
            // execute fetch request
            var error: NSError? = nil
            if var results = context.executeFetchRequest(request, error: &error){
                for obj in results {
                    let model = obj as WKSBookedAirportShop
                    println(model.name)
                }
            }
        }
        
    }
    
    // MARK: did clicked Close Button
    @IBAction func didClickedCloseButton(sender: AnyObject) {
        // find obj
        //saveAirportShopInDB(airportShop!)
        fetchAirportShopInDB(airportShop!)
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
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