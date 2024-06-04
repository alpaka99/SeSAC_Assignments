//
//  LabelType.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit


enum LabelType {
    static let type = UILabel.self
    
    case letsFlixTitle(String)
    case title(String)
    case information(String)
    
    
    var text: String {
        switch self {
        case .information(let text), .title(let text), .letsFlixTitle(let text):
            return text
        }
    }
    var textColor: UIColor {
        switch self {
        case .letsFlixTitle(_):
            return .systemRed
        case .title(_), .information(_):
            return .white
        }
    }
    
    var font: UIFont {
        switch self {
        case .letsFlixTitle(_):
            return UIFont.systemFont(ofSize: 32, weight: .black)
        case .title(_):
            return UIFont.systemFont(ofSize: 16, weight: .medium)
        case .information(_):
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }
    
    // generic 함수로 만드는 방법 없을까?
    func build() -> UILabel {
        let label = Self.type.init()
        
        label.text = self.text
        label.textColor = self.textColor
        label.font = self.font
        
        return label
    }
}
