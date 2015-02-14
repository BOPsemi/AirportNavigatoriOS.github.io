//
//  WKSViewLayout.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/11/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit

public func setupViewLayout(view: UIView!){
    view.contentMode = .ScaleAspectFill
    view.layer.cornerRadius = 5.0
    view.layer.masksToBounds = true
}