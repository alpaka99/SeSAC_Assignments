//
//  Extension+UITableViewCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
