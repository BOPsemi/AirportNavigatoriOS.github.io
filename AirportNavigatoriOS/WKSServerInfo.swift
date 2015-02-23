//
//  ServerInfo.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/8/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

enum WKSServerInfo: String{
    case ShopJSONServer = "http://192.168.10.26:9000/Airportshop/Fetchshop.json?"
    case ShopItemJSONServer = "http://192.168.10.26:9000/Airportshop/Fetchitem.json?"
    case ShopImageDataServer = "http://192.168.10.26:9000/Airportshop/ViewImage?"
}

/*
switch self {
case .Localhoset:
    return "http://:9000/"
case .ShopJSONDataHost:
    return "http://192.168.10.26:9000/Airportshop/View.json"
case .ImageDataHost:
    return "http://192.168.10.26:9000/Airportshop/ViewImage?fileName="
case .ShopJSONDataHostByKey:
    return "http://192.168.10.26:9000/Airportshop/Fetchshop.json?"
case .ShopItemJSONDataHostBykey:
    return "http://192.168.10.26:9000/Airportshop/Fetchitem.json?"
default:
    return ""
}
*/