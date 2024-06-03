//
//  BackgroundBuildable.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import Foundation
import UIKit

protocol BackgroundBuildable {
    var backgrounds: [BackgroundType : UIView] { get set }
    func buildBackgroundsUI()
}


extension BackgroundBuildable {
    func buildBackgroundsUI() {
        self.backgrounds.keys.forEach { backgroundType in
            buildBackgroundUI(backgroundType)
        }
    }
    
    func buildBackgroundUI(_ backgroundType: BackgroundType) {
        if let backgrounds = self.backgrounds[backgroundType] {
            
        }
    }
}

enum BackgroundType {
    case magazineCell
    case restaurantCell
    case travelCell
    case travelAdCell
}
