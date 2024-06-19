//
//  Constants.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import CoreLocation

struct ImageName {
    static let restaurantTabImage = "fork.knife.circle.fill"
    static let weatherCheckTabImage = "cloud.circle.fill"
    static let targetImage = "scope"
    static let locationImage = "location.fill"
    static let shareImage = "square.and.arrow.up"
    static let refreshImage = "arrow.clockwise"
    
    
    static let weatherCheckBackgroundImage = "weatherCheckBackgroundImage"
}


struct LocationCoordinate {
    static let dummyLocation = CLLocationCoordinate2D(
        latitude: 37.51780,
        longitude: 126.88629
    )
}

struct DateHelper {
    static let dateFormatter = DateFormatter()
    static let weatherDateFormat = "MM월 dd일 HH시 mm분"
}
