//
//  Reusable.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

protocol Reusable {
    
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
