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
    
    case travelCityTitle
    case travelCityDescription
    case travelCityGrade
    
    case travelCityAdTitle
    case travelCityAdBadge
    
        
    var backgroundColor: UIColor {
        switch self {
        case .travelCityAdTitle:
            return UIColor.getRandomColor()
        case .travelCityAdBadge:
            return .white
            
        case .magazineTitle, .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .travelCityTitle, .travelCityDescription,
                .travelCityGrade:
            return .clear
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .travelCityAdTitle:
            return 8
        case .travelCityAdBadge:
            return 4
        case .magazineTitle, .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .travelCityTitle, .travelCityDescription,
                .travelCityGrade:
            return 0
        }
    }
    
    var clipsToBounds: Bool {
        switch self {
        case .travelCityAdTitle, .travelCityAdBadge:
            return true
        case .magazineTitle, .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .travelCityTitle, .travelCityDescription,
                .travelCityGrade:
            return false
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .travelCityAdTitle:
            return 24
        case .magazineTitle, .restaurantName:
            return 20
        case .magazineSubtitle, .restaurantCategory, .travelCityTitle:
            return 16
        case .travelCityDescription:
            return 14
        case .magazineDate, .restaurantPhoneNumber, .travelCityGrade, .travelCityAdBadge:
            return 12
        }
    }
    
    var fontWeight: UIFont.Weight {
        switch self {
        case .magazineTitle, .travelCityAdTitle:
            return .heavy
        case .magazineSubtitle, .travelCityTitle, .travelCityAdBadge:
            return .bold
        case .magazineDate, .restaurantPhoneNumber, .travelCityDescription, .travelCityGrade:
            return .semibold
        case .restaurantName:
            return .regular
        case .restaurantCategory:
            return .medium
        }
    }
    
    var numberOfLines: Int {
        switch self {
        case .magazineTitle, .travelCityDescription, .travelCityAdTitle:
            return 0
        case .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .travelCityTitle, .travelCityGrade, .travelCityAdBadge:
            return 1
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .magazineTitle, .magazineSubtitle, .restaurantName, .restaurantPhoneNumber, .restaurantCategory, .travelCityTitle, .travelCityDescription, .travelCityGrade:
            return .left
        case .travelCityAdTitle, .travelCityAdBadge:
            return .center
        case .magazineDate:
            return .right
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .magazineTitle, .restaurantPhoneNumber, .travelCityTitle, .travelCityAdTitle, .travelCityAdBadge:
            return .black
        case .travelCityDescription:
            return .systemGray2
        case .magazineSubtitle, .magazineDate, .restaurantCategory, .travelCityGrade:
            return .systemGray4
        case .restaurantName:
            return .systemBlue
        }
    }
}
