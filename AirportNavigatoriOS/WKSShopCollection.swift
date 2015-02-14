//
//  WKSShopCollection.swift
//  AirportNavigatoriOS
//
//  Created by Kazufumi Watanabe on 2/8/15.
//  Copyright (c) 2015 Kazufumi Watanabe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WKSShopCollection: UICollectionViewController,
                        UICollectionViewDataSource,
                        UICollectionViewDelegate,
                        UICollectionViewDelegateFlowLayout{
    
    // MARK: Properties
    private lazy var airportShops = [WKSAirportShop]()
    private var imageCashe: NSCache?
    
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(shops: [WKSAirportShop]){
        super.init()
        
        // initialize airport shop list
        airportShops = shops
        
        // initialize image cache
        imageCashe = NSCache()
    }
    
    // MARK: display animation
    private func imageFadeinAnimation(imageview: UIImageView?){
        // setup animation
        imageview?.alpha = 0
        UIView.beginAnimations("fadeIn", context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.setAnimationDuration(0.3)
        imageview?.alpha = 1
        UIView.commitAnimations()
    }
    
    // MARK: make floor string
    private func makeFloorStr(floor: Int) -> String {
        var floorStr: String?
        let floorLabel = ["BF/1F","2F","3F","4F","5F"]

        switch floor {
        case 0:
            floorStr = "floor" + " : " + floorLabel[0]
        case 1:
            floorStr = "floor" + " : " + floorLabel[1]
        case 2:
            floorStr = "floor" + " : " + floorLabel[2]
        case 3:
            floorStr = "floor" + " : " + floorLabel[3]
        case 4:
            floorStr = "floor" + " : " + floorLabel[4]
        default:
            floorStr = "floor" + " : " + floorLabel[0]
        }
        
        return floorStr!
    }
    
    
    // MARK: CollectionView Delegate and Datasource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return airportShops.count
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // selected shop
        let shop = airportShops[indexPath.row] as WKSAirportShop
        
        // extract image data from cache and post object to notification center
        if let image: UIImage! = self.imageCashe?.objectForKey(shop.uuid) as? UIImage {
            
            // make selected airport shop object for post notification center
            let airportshop = WKSSelectedAirportShop(imageData: image, shopData: shop)
            
            NSNotificationCenter.defaultCenter().postNotificationName(
                WKSNotificationInfo.AirportShopSelected.rawValue,
                object: airportshop)
        }
        
        // de-selected item
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)

    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell  = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        let shop = airportShops[indexPath.row]
        let url: String = shop.imageurls[0]
        let uuid: String = shop.uuid
        
        // setup view tag
        var imageView = cell.viewWithTag(WKSCollectionCell.ImageView.rawValue) as? UIImageView
        var title = cell.viewWithTag(WKSCollectionCell.Title.rawValue) as? UILabel
        var comment = cell.viewWithTag(WKSCollectionCell.Comment.rawValue) as? UITextView
        var floor = cell.viewWithTag(WKSCollectionCell.Floor.rawValue) as? UILabel
        
        // view setup
        setupViewLayout(cell)
        imageView?.image = nil
        imageView?.contentMode = .ScaleAspectFill
        
        // setup animation
        imageFadeinAnimation(imageView)
        
        // view setup
        title?.text = shop.name
        comment?.text = shop.comment
        floor?.text = makeFloorStr(shop.floor)
        
        
        // download shop image
        Alamofire.request(.GET, url).response { (request, response, data, error) -> Void in
            
            // set image to imageView
            let imageData = data as? NSData
            let image = UIImage(data: imageData!)
            
            imageView?.image = image
            
            // cache image data
            self.imageCashe?.setObject(image!, forKey: uuid)
                            
            return
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = UIScreen.mainScreen().bounds.size.width
        let size = CGSizeMake(width-4.0, 220)
            
        return size
    }
}