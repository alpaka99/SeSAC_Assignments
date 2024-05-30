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
