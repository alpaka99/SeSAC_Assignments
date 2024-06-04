//
//  ImageViewType.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

enum ImageViewType {
    static let type = UIImageView.self
    
    case poster(String)
    
    var cornerRadius: CGFloat {
        switch self {
        case .poster(_):
            return 8
        }
    }
    
    var clipsToBounds: Bool {
        switch self {
        case .poster(_):
            return true
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .poster(_):
            return .systemGray4
        }
    }
    
    var imageName: String {
        switch self {
        case .poster(let imageName):
            return imageName
        }
    }
    
    
    func build() -> UIImageView {
        let imageView = Self.type.init()
        
        imageView.layer.cornerRadius = self.cornerRadius
        imageView.clipsToBounds = self.clipsToBounds
        imageView.backgroundColor = self.backgroundColor
        imageView.image = UIImage(named: self.imageName)
        
        return imageView
    }
}
