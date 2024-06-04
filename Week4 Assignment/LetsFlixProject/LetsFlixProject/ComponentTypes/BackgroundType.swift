//
//  BackgroundType.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

enum BackgroundType {
    static let type = UIView.self
    
    case transparent
    case colored
    
    
    var backgroundColor: UIColor {
        switch self {
        case .colored:
            return .black
            
        case .transparent:
            return .clear
        }
    }
    
    func build() -> UIView {
        let backgroundView = Self.type.init()
        
        backgroundView.backgroundColor = self.backgroundColor
        
        return backgroundView
    }
}
