//
//  mapInterfaceController.swift
//  wheresmynearest
//
//  Created by Rommel Rico on 4/18/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation

class mapInterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    @IBOutlet weak var placeLabel: WKInterfaceLabel!
    @IBOutlet weak var map: WKInterfaceMap!
    var latitude: Double = 0
    var longitude: Double = 0
    var placeName: String = ""
    var placeType: String = ""
    var locationManager = CLLocationManager()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if context != nil {
            placeType = context as! String
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/search/json?location=\(locationManager.location.coordinate.latitude),\(locationManager.location.coordinate.longitude)&radius=2000&name=\(placeType)&key=AIzaSyCxYQhOaZK6PQb-mTvjQnavWtJcFHz9JGU")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                let returnedPlaces: NSArray? = jsonResult["results"] as? NSArray
                if returnedPlaces != nil {
                    if let returnedPlace = returnedPlaces?[0] as? NSDictionary {
                        if let name = returnedPlace["name"] as? NSString {
                            self.placeName = name as String
                        }
                        if let geometry = returnedPlace["geometry"] as? NSDictionary {
                            if let location = geometry["location"] as? NSDictionary {
                                if let lat = location["lat"] as? Double {
                                    self.latitude = lat
                                }
                                if let lng = location["lng"] as? Double {
                                    self.longitude = lng
                                }
                            }
                        }
                    }
                }
                
            } else {
                println(error)
            }
            
            if self.latitude != 0 && self.longitude != 00 && self.placeName != "" {
                //Location is not null, so initialize maps
                let location = CLLocationCoordinate2D(latitude: self.latitude as CLLocationDegrees, longitude: self.longitude as CLLocationDegrees)
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let region = MKCoordinateRegion(center: location, span: span)
                self.map.setRegion(region)
                self.placeLabel.setText(self.placeName)
                self.map.addAnnotation(location, withPinColor: WKInterfaceMapPinColor.Red)
            }
        })
        task.resume()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
