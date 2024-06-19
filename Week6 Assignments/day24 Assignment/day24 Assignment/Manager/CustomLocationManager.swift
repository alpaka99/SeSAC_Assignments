//
//  LocationManager.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import CoreLocation

class LocationStore: NSObject {
    internal static let shared = LocationStore()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D = LocationCoordinate.dummyLocation
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
}

extension LocationStore: CLLocationManagerDelegate {
    func checkLocationAvailabilty() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                DispatchQueue.main.async { [weak self] in
                    self?.checkAuthorizationStatus()
                }
            } else {
                print("Location blocked from iOS System")
            }
        }
    }
        
    
    func checkAuthorizationStatus() {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = LocationStore.shared.locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print(#function, "not determined")
            LocationStore.shared.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            print(#function, "authorized")
            LocationStore.shared.locationManager.startUpdatingLocation()
        default:
            print("Error")
        }
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAvailabilty()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location.coordinate
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func updateLocation() {
        Self.shared.locationManager.startUpdatingLocation()
    }
    
    func fetchCurrentLocation() -> CLLocationCoordinate2D {
        self.updateLocation()
        return currentLocation
    }
}
