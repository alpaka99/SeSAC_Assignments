//
//  ButtonType.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

enum ButtonType {
    static let type = UIButton.self
    
    case common(String, String)
    case transparentButton(String, String)
    
    var backgroundColor: UIColor {
        switch self {
        case .common(_, _):
            return .white
        case .transparentButton(_, _):
            return .darkGray
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .common(_, _):
            return .black
        case .transparentButton(_, _):
            return .white
        }
    }
    
    var systemName: String {
        switch self {
        case .common(let imageName, _), .transparentButton(let imageName, _):
            return imageName
        }
    }
    
    var title: String {
        switch self {
        case .common(_, let text), .transparentButton(_, let text):
            return text
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .common(_, _), .transparentButton(_, _):
            return 8
        }
    }
    
    var font: UIFont {
        switch self {
        case .common(_, _), .transparentButton(_, _):
            return UIFont.systemFont(ofSize: 12, weight: .bold)
        }
    }
    
    func build() -> UIButton {
        let button = Self.type.init()
        
        var config = UIButton.Configuration.plain()
        
        config.title = self.title
        config.baseForegroundColor = self.titleColor
        config.image = UIImage(systemName: self.systemName)
        config.background.backgroundColor = self.backgroundColor
        
        
        button.configuration = config

        button.layer.cornerRadius = self.cornerRadius
        button.backgroundColor = self.backgroundColor
        
        
        return button
    }
}
