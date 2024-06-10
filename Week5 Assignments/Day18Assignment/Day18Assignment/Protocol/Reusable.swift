//
//  Reusable.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

protocol Reusable {
    static var identifier: String { get }
}


extension Reusable {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}
