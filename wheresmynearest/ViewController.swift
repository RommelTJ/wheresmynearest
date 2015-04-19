//
//  ViewController.swift
//  wheresmynearest
//
//  Created by Rommel Rico on 4/18/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var defaults = NSUserDefaults(suiteName: "group.com.rommelrico.wheresmynearest")
    var places = [String]()
    
    @IBOutlet weak var place1: UITextField!
    @IBOutlet weak var place2: UITextField!
    @IBOutlet weak var place3: UITextField!
    @IBOutlet weak var place4: UITextField!
    
    @IBAction func doUpdate(sender: AnyObject) {
        //TODO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

