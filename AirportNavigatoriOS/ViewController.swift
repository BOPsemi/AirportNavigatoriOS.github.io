//
//  ViewController.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/5/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                    UITextFieldDelegate{
    
    // View Controller
    
    // MARK: Outlets
    @IBOutlet weak var airportTexField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Private UI
    private var airportPickerView:UIPickerView!
    
    // MARK: private properties
    private var airportPicker: WKSAirportPicker?
    private var terminalTable: WKSTableView?
    private var shopCollection: WKSShopCollection?
    private var airportShopController: WKSAirportShopController?
    
    private var pickedTerminal: String?
    private var pickedAirport: WKSAirport?{
        didSet{
            // update terminal list
            let terminallist = WKSAirportTerminalListMaker(airport: pickedAirport!).terminals
            
            // initialize tableview
            terminalTable = WKSTableView(terminals: terminallist)
            tableView.delegate = terminalTable
            tableView.dataSource = terminalTable
            
            // reload
            tableView.reloadData()
            
            // show tableView
            tableView.hidden = false
        }
    }
    
    
    // MARK: textField delegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        // setup title
        title = updateTitle(pickedAirport?.IATAcode, terminal: pickedTerminal)
        
        // hidden tableview
        tableView.hidden = true
        
        // select text field
        switch textField.tag{
        case WKSMainTextField.Airport.rawValue:
            
            // setup picker view for input view
            clickedAirportTexFieldAction()
            
        default:
            break
        }
        
        // resign first responder
        airportTexField.resignFirstResponder()
        
        return true
    }
    
    // MARK: Notification Center
    private func addNotificationCenter(){
        
        // airportPicker notification center
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateAirportTexField:",
            name: WKSNotificationInfo.AirportPicker.rawValue,
            object: nil)

        // terminalTable notification center 
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updataAirportTerminal:",
            name: WKSNotificationInfo.TerminalTable.rawValue,
            object: nil)
    }
    
    // MARK: updateAirportTexField/didSelectedAirport
    func updateAirportTexField(notification: NSNotification?){
        if let airport: WKSAirport = notification?.object as? WKSAirport {
            
            // update airport text field
            airportTexField.text = airport.AirportEnName!
            pickedAirport = airport
            
            // resign first responder
            airportTexField.resignFirstResponder()
        }
    }

    // MARK: didSelectedTerminal
    func updataAirportTerminal(notification:NSNotification?){
        if let terminal: String! = notification?.object as? String{
            
            // update terminal infomation
            pickedTerminal = terminal
            
            // update title
            title = updateTitle(pickedAirport?.IATAcode, terminal: pickedTerminal)
            
            // prepare the fetch data
            let iataCode = pickedAirport?.IATAcode as String!
            let searchKey = ["iatacode":iataCode, "terminal":terminal]
            
            // post notification
            NSNotificationCenter.defaultCenter().postNotificationName(
                "didSelectedAirportShopInf",
                object: pickedAirport,
                userInfo: searchKey)
        }
    }
    
    // MARK: update title
    private func updateTitle(airportIATAcode: String?, terminal: String?) -> String!{
        var viewtitle = "Airport Naviagtor"
        
        if airportIATAcode != nil && terminal != nil {
            viewtitle = airportIATAcode! + "/" + terminal!
        }
        
        return viewtitle
    }
    
    // MARK: Airport text field clicked Action
    private func clickedAirportTexFieldAction(){
        // make airport list
        let airportlist = WKSAirportListMaker(plistname: "Airport").list
        
        // initialize airportpicker object
        airportPicker = WKSAirportPicker(airpotlist: airportlist)
        
        // initialize picker view
        airportPickerView = UIPickerView()
        airportPickerView.backgroundColor = UIColor.whiteColor()
        airportPickerView.showsSelectionIndicator = true
        
        // setup airportpicker
        airportPickerView.delegate = airportPicker
        airportPickerView.dataSource = airportPicker
        
        // change inputview to picker
        airportTexField.inputView = airportPickerView
    }
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        airportTexField.delegate = self
        
        // setup airport shop collection view
        airportShopController = WKSAirportShopController()
        airportShopController?.collectionView = collectionView
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        
        // initialize notification center
        addNotificationCenter()
        
        // initialize view title
        title = updateTitle(pickedAirport?.IATAcode, terminal: pickedTerminal)
    }
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

