//
//  Dictionary+Switch.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
//

import Foundation

extension Dictionary {
    mutating func switchKey(_ originalKey: Self.Key, with newKey: Self.Key) {
        if let value = self.removeValue(forKey: originalKey) {
            self[newKey] = value
        }
    }
}
