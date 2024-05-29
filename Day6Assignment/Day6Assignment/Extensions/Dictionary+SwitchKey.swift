//
//  Dictionary+SwitchKey.swift
//  Day6Assignment
//
//  Created by user on 5/22/24.
//

extension Dictionary {
    mutating func switchKey(_ originalKey: Self.Key, with newKey: Self.Key) {
        if let value = self.removeValue(forKey: originalKey) {
            self[newKey] = value
        }
    }
}
