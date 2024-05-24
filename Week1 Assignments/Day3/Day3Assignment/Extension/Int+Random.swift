//
//  Int+Random.swift
//  Day3Assignment
//
//  Created by user on 5/16/24.
//

import Foundation

extension Int {
    static func randomNumbers(_ range: Range<Int>, numberOfPicks: Int = 1) -> [Int] {
        var numberSet: Set<Int> = Set()
        
        while numberSet.count < numberOfPicks {
            numberSet.insert(Int.random(in: range))
        }
        return Array(numberSet)
    }
}
