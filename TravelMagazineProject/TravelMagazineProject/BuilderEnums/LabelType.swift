//
//  LabelType.swift
//  TravelMagazineProject
//
//  Created by user on 5/28/24.
//

import Foundation
import UIKit

enum LabelType {
    case magazineTitle
    case magazineSubtitle
    case magazineDate
    
    case restaurantName
    case restaurantCategory
    case restaurantPhoneNumber
    
    case popularCityTitle
    case popularCityDescription
    case popularCityGrade
    
    var numberOfLines: Int {
        switch self {
        case .magazineTitle, .popularCityDescription:
            return 0
        case .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .popularCityTitle, .popularCityGrade:
            return 1
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .magazineTitle, .magazineSubtitle, .restaurantName, .restaurantPhoneNumber, .restaurantCategory, .popularCityTitle, .popularCityDescription, .popularCityGrade:
            return .left
        case .magazineDate:
            return .right
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .magazineTitle, .restaurantName:
            return 20
        case .magazineSubtitle, .restaurantCategory, .popularCityTitle:
            return 16
        case .popularCityDescription:
            return 14
        case .magazineDate, .restaurantPhoneNumber, .popularCityGrade:
            return 12
        }
    }
    
    var fontWeight: UIFont.Weight {
        switch self {
        case .magazineTitle:
            return .heavy
        case .magazineSubtitle, .popularCityTitle:
            return .bold
        case .magazineDate, .restaurantPhoneNumber, .popularCityDescription, .popularCityGrade:
            return .semibold
        case .restaurantName:
            return .regular
        case .restaurantCategory:
            return .medium
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .magazineTitle, .restaurantPhoneNumber, .popularCityTitle:
            return .black
        case .popularCityDescription:
            return .systemGray2
        case .magazineSubtitle, .magazineDate, .restaurantCategory, .popularCityGrade:
            return .systemGray4
        case .restaurantName:
            return .systemBlue
        }
    }
}
