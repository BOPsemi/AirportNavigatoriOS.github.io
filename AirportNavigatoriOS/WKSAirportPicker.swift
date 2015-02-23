//
//  WKSAirportPicker.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/5/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

class WKSAirportPicker: UIPickerView,
                        UIPickerViewDataSource,
                        UIPickerViewDelegate{
    // MARK: Properties
    private lazy var airportlist = [WKSAirport]()
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(airpotlist list:[WKSAirport]){
        super.init()
        self.airportlist = list
    }

    // MARK: PickerView Delegate and DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return airportlist.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return airportlist[row].AirportEnName as String!
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let obj = airportlist[row] as WKSAirport
        
        // Post selected object to notification center
        NSNotificationCenter.defaultCenter().postNotificationName(WKSNotificationInfo.AirportPicker.rawValue, object: obj)
    }
    
}