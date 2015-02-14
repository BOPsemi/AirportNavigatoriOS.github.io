//
//  NotificationInfo.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/8/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

enum WKSNotificationInfo: String{
    case AirportPicker = "didSelectedAirport"
    case TerminalTable = "didSelectedTerminal"
    case AirportShopInf = "didSelectedAirportShopInf"
    case AirportShopCollection = "fetchedAirportShop"
    case AirportShopSelected = "didSelectedAirportShop"
    case AirportShopItemlist = "fetchedAirportShopItems"
}
