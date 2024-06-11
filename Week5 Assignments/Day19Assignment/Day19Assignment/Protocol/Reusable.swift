//
//  Reusable.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension UICollectionViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
