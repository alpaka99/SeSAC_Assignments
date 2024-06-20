//
//  Reusable.swift
//  day24 Assignment
//
//  Created by user on 6/20/24.
//
import UIKit

protocol Reusable {
    
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {
    
}
