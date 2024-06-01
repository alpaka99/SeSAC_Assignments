//
//  Constants.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import CoreLocation


internal struct MapConstants {
    private static let dummyLatitude: Double = 37.517800
    private static let dummyLongitude: Double = 126.886288
    
    internal static var initialCenter: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: dummyLatitude, longitude: dummyLongitude)
    }
    
    internal static let dummyLatitudinalMeters: Double = 500
    internal static let dummyLongitudinalMeters: Double = 500
}
