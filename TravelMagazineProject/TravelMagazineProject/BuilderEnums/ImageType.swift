//
//  ImageType.swift
//  TravelMagazineProject
//
//  Created by user on 5/28/24.
//

import Foundation
import UIKit

//MARK: 연산 프로퍼티 순서를 어떻게 할까? 알파벳순?
internal enum ImageViewType {
    case magazine
    case restaurant
    case popularCity
    
    
    private var backgroundColor: UIColor {
        switch self {
        case .magazine, .restaurant, .popularCity:
            return .systemGray4
        }
    }
    
    private var borderColor: CGColor {
        switch self {
        case .magazine:
            return UIColor.systemGray4.cgColor
        case .restaurant, .popularCity:
            return UIColor.clear.cgColor
        }
    }
    
    private var borderWidth: CGFloat {
        switch self {
        case .magazine:
            return 1
        case .restaurant, .popularCity:
            return 0
        }
    }
    
    private var clipsToBounds: Bool {
        switch self {
        case .magazine, .restaurant, .popularCity:
            return true
        }
    }
    
    private var cornerRadius: CGFloat {
        switch self {
        case .magazine:
            return 16
        case .restaurant, .popularCity:
            return 8
        }
    }
    
    private var contentMode: UIView.ContentMode {
        switch self {
        case .magazine, .restaurant, .popularCity:
            return .scaleAspectFill
        }
    }
}
