//
//  ViewController.swift
//  wheresmynearest
//
//  Created by Rommel Rico on 4/18/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var defaults = NSUserDefaults(suiteName: "group.com.rommelrico.wheresmynearest")
    var places = [String]()
    
    @IBOutlet weak var place1: UITextField!
    @IBOutlet weak var place2: UITextField!
    @IBOutlet weak var place3: UITextField!
    @IBOutlet weak var place4: UITextField!
    
    @IBAction func doUpdate(sender: AnyObject) {
        places = [place1.text, place2.text, place3.text, place4.text]
        defaults?.setObject(places, forKey: "places")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
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
        
        place1.text = places[0]
        place2.text = places[1]
        place3.text = places[2]
        place4.text = places[3]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

