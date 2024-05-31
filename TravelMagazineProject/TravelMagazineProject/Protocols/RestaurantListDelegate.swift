//
//  RestaurantListDelegate.swift
//  TravelMagazineProject
//
//  Created by user on 5/31/24.
//

import Foundation

protocol RestaurantListDelegate: NSObject {
    func fetchFilteredList() -> [Restaurant]
    
    func moveToAnnotation(for annotation: Restaurant)
}
