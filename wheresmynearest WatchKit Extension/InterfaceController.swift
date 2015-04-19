//
//  InterfaceController.swift
//  wheresmynearest WatchKit Extension
//
//  Created by Rommel Rico on 4/18/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    var places = [String]()

    var defaults = NSUserDefaults(suiteName: "group.com.rommelrico.wheresmynearest")
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var storedPlaces: AnyObject? = defaults?.objectForKey("places")
        if let storedPlacesArray = storedPlaces as? NSArray {
            for (index, value) in enumerate(storedPlacesArray) {
                if let placeName = value as? String {
                    places.append(placeName)
                }
            }
        }
        
        if places.count == 0 {
            places = ["cafe", "library", "bar", "restaurant"]
            defaults?.setObject(places, forKey: "places")
        }
        
        println(places)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
