//
//  TextFieldType.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

// 기능 혹은 생김새에 따라 구분한 textfield type
enum TextFieldType {
    static let type = UITextField.self
    
    case register(String)
    
    var placeholder: String {
        switch self {
        case .register(let placeholder):
            return placeholder
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .register(_):
            return .darkGray
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .register(_):
            return .white
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .register(_):
            return .white
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .register(_):
            return .center
        }
    }
    
    var font: UIFont {
        switch self {
        case .register(_):
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .register(_):
            return 8
        }
    }
    
    var attributedPlaceholder: NSAttributedString {
        switch self {
        case .register(let placeholder):
            let attributedString = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.cgColor])
            
            return attributedString
        }
    }
    
    func build() -> UITextField {
        let textField = Self.type.init()
        
        textField.attributedPlaceholder = self.attributedPlaceholder
        textField.backgroundColor = self.backgroundColor
        textField.tintColor = self.tintColor
        textField.textColor = self.textColor
        textField.textAlignment = self.textAlignment
        textField.layer.cornerRadius = self.cornerRadius
        
        return textField
    }
}
