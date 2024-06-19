//
//  UIButton+Extension.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import UIKit

extension UIButton {
    var config: UIButton.Configuration {
        return self.configuration ?? UIButton.Configuration.plain()
    }
    
    func image(systemName: String) -> Self {
        var config = self.config
        config.image = UIImage(systemName: systemName)
        
        self.configuration = config
        return self
    }
    
    func backgroundColor(with color: UIColor) -> Self {
        var config = self.config
        config.background.backgroundColor = color
        
        self.configuration = config
        return self
    }
    
    func tintColor(with color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    func cornerStyle(style: UIButton.Configuration.CornerStyle) -> Self {
        var config = self.config
        config.cornerStyle = style
        
        self.configuration = config
        return self
    }
}
