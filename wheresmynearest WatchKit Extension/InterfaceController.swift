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
    
    @IBOutlet weak var table: WKInterfaceTable!
    var places = [String]()

    var defaults = NSUserDefaults(suiteName: "group.com.rommelrico.wheresmynearest")
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/search/json?location=-33.88471,151.218237&radius=100&sensor=true&key=AIzaSyCxYQhOaZK6PQb-mTvjQnavWtJcFHz9JGU")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                println(jsonResult)
            } else {
                println(error)
            }
        })
        task.resume()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
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
        
        table.setNumberOfRows(places.count, withRowType: "tableRowController")
        for (index, place) in enumerate(places) {
            let row = table.rowControllerAtIndex(index) as! tableRowController
            row.tableRowLabel.setText(place)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
