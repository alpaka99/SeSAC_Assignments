//
//  Constants.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

struct Screen {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
}

extension UIColor {
    static var TGBackgroundColor: UIColor {
        return UIColor(
            red: 245/255,
            green: 255/255,
            blue: 252/255,
            alpha: 1
        )
    }
    
    static var TGNavyColor: UIColor {
        return UIColor (
            red: 77/255,
            green: 106/255,
            blue: 120/255,
            alpha: 1
        )
    }
}
