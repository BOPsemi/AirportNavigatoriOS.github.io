//
//  WKSBookedAirportShopViewController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/24/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSBookedAirportShopViewController: UIViewController {
    // MARK: Properties
    
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: view close action
    @IBAction func didClickedCloseButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}