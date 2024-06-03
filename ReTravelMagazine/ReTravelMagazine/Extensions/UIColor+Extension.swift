//
//  UIColor+Extension.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        return UIColor.init(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
}
