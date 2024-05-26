//
//  UserDefaultable.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import Foundation

protocol UserDefaultable: Codable {
    static func getUserDefaultKey() -> String
}

extension UserDefaultable {
    static func getUserDefaultKey() -> String {
        return String(describing: Self.self)
    }
}
