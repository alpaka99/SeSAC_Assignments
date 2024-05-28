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
    
    case popularCityAdTitle
    case popularCityAdBadge
    
        
    private var backgroundColor: UIColor {
        switch self {
        case .popularCityAdTitle:
            return UIColor.getRandomColor()
        case .popularCityAdBadge:
            return .white
            
        case .magazineTitle, .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .popularCityTitle, .popularCityDescription,
                .popularCityGrade:
            return .clear
        }
    }
    
    private var cornerRadius: CGFloat {
        switch self {
        case .popularCityAdTitle:
            return 8
        case .popularCityAdBadge:
            return 4
        case .magazineTitle, .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .popularCityTitle, .popularCityDescription,
                .popularCityGrade:
            return 0
        }
    }
    
    private var clipsToBounds: Bool {
        switch self {
        case .popularCityAdTitle, .popularCityAdBadge:
            return true
        case .magazineTitle, .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .popularCityTitle, .popularCityDescription,
                .popularCityGrade:
            return false
        }
    }
    
    private var fontSize: CGFloat {
        switch self {
        case .popularCityAdTitle:
            return 24
        case .magazineTitle, .restaurantName:
            return 20
        case .magazineSubtitle, .restaurantCategory, .popularCityTitle:
            return 16
        case .popularCityDescription:
            return 14
        case .magazineDate, .restaurantPhoneNumber, .popularCityGrade, .popularCityAdBadge:
            return 12
        }
    }
    
    private var fontWeight: UIFont.Weight {
        switch self {
        case .magazineTitle, .popularCityAdTitle:
            return .heavy
        case .magazineSubtitle, .popularCityTitle, .popularCityAdBadge:
            return .bold
        case .magazineDate, .restaurantPhoneNumber, .popularCityDescription, .popularCityGrade:
            return .semibold
        case .restaurantName:
            return .regular
        case .restaurantCategory:
            return .medium
        }
    }
    
    private var numberOfLines: Int {
        switch self {
        case .magazineTitle, .popularCityDescription, .popularCityAdTitle:
            return 0
        case .magazineSubtitle, .magazineDate, .restaurantName, .restaurantCategory, .restaurantPhoneNumber, .popularCityTitle, .popularCityGrade, .popularCityAdBadge:
            return 1
        }
    }
    
    private var textAlignment: NSTextAlignment {
        switch self {
        case .magazineTitle, .magazineSubtitle, .restaurantName, .restaurantPhoneNumber, .restaurantCategory, .popularCityTitle, .popularCityDescription, .popularCityGrade:
            return .left
        case .popularCityAdTitle, .popularCityAdBadge:
            return .center
        case .magazineDate:
            return .right
        }
    }
    
    private var textColor: UIColor {
        switch self {
        case .magazineTitle, .restaurantPhoneNumber, .popularCityTitle, .popularCityAdTitle, .popularCityAdBadge:
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
