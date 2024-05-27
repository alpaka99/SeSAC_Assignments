//
//  UILabel+Extension.swift
//  Day7Assignments
//
//  Created by user on 5/27/24.
//

import UIKit

extension UILabel {
    func setPrimaryLabel() {
        self.font = .boldSystemFont(ofSize: 17)
        self.textAlignment = .left
        self.backgroundColor = .lightGray
        self.textColor = .darkGray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }
}
