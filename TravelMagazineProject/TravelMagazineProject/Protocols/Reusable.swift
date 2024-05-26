//
//  Reusable.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

protocol Reusable {
    static func getReuseIdentifier() -> String
}

extension Reusable {
    static func getReuseIdentifier() -> String {
        return String(describing: Self.self)
    }
}
