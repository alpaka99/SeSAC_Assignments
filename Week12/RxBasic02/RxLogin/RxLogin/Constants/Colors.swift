//
//  Colors.swift
//  RxLogin
//
//  Created by user on 8/6/24.
//

import Foundation

import UIKit

enum Color {
    case red
    case green
    case blue
    
    var asUIColor: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .blue:
            return .systemBlue
        case .green:
            return .systemGreen
        }
    }
}
