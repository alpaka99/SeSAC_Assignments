//
//  Extension+UIColor.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

extension UIColor {
    static func getRandomColor() -> UIColor { // MARK: 왜 여기서 Self를 못쓸까?
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
}
