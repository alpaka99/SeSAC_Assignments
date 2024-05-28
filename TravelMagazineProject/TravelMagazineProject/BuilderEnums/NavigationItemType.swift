//
//  NavigationItemType.swift
//  TravelMagazineProject
//
//  Created by user on 5/28/24.
//

import Foundation

enum NavigationItemType: String {
    case magazine
    case travel
    case restaurant
    
    var title: String {
        switch self {
        case .magazine, .restaurant:
            return "SeSAC " + self.rawValue
        case .travel:
            return "도시 상세 정보"
        }
    }
}
