//
//  CellState.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

struct CellState: UserDefaultable {
    let states: [CellInfo]
}


struct CellInfo: Codable {
    let isFavorite: Bool
}
