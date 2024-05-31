//
//  Constants.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit


struct BasicCellInfo {
    static let text: String = "Something went wrong...😞"
}

struct AdBadgeCell {
    static let text: String = "Ad"
}


struct PopularCityCell {
    static var collectionViewWidth: CGFloat = 0
    static var width: CGFloat {
        return collectionViewWidth / 2.5
    }
    static var height: CGFloat {
        return width / 1.3
    }
}

struct SFSymbolConfig {
    static let large: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24, weight: .semibold))
}


struct ScreenSize {
    static let width: CGFloat = UIScreen.main.bounds.width
    static let height: CGFloat = UIScreen.main.bounds.height
    static let navigationBarConstant: CGFloat = 90
}

struct Coordinate {
    static let dummyLatitude: Double = 37.554921
    static let dummyLongitude: Double = 126.970345
    
    static let sesacLatitude: Double = 37.517800
    static let sesacLongitude: Double = 126.886288
    
    static let defaultLatitudinalMeters: Double = 500
    static let defaultLongitudinalMeters: Double = 500
    
}
