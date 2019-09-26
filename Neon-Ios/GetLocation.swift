//
//  GetLocation.swift
//  Neon-Ios
//
//  Created by Akhilendra Singh on 2/5/19.
//  Copyright © 2019 Girnar. All rights reserved.
//

import Foundation
import CoreLocation

class GetLocation : CLLocation, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var userLocation:CLLocation!
    
    func getLocation() -> CLLocation{
        determineMyCurrentLocation();
        return userLocation
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
