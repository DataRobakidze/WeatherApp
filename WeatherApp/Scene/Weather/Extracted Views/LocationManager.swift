//
//  LocationManager.swift
//  WeatherApp
//
//  Created by gvantsa gvagvalia on 6/12/24.
//

import Foundation
import CoreLocation
import MapKit
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    let manager = CLLocationManager()
//    
//    @Published var location: CLLocationCoordinate2D?
//    @Published var isLoading = false
//    
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
//    
//    func requestLocation() {
//        isLoading = true
//        manager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first?.coordinate
//        isLoading = false
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error getting location", error)
//        isLoading = false
//    }
//}

@MainActor
class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    private let locationManager = CLLocationManager()

    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()  // must update Info.plist

        locationManager.delegate = self
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}
