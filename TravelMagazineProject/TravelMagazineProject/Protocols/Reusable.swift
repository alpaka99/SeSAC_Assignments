//
//  Reusable.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable {
    
}
