//
//  ShopDetailViewController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/9/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

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
    
    // MARK: Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shopTitle: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: bookmark switch action
    @IBAction func bookmarkSwitch(sender: AnyObject) {
        let sw = sender as UISwitch
        if sw.on {
            
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
    
    // MARK: did clicked Close Button
    @IBAction func didClickedCloseButton(sender: AnyObject) {
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