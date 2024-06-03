//
//  Extension+Double.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import Foundation

extension Double? {
    func getStars() -> String {
        if let grade = self {
            let flooredGrade = Int(floor(grade))
            
            let filledStars = String(repeating: "★", count: flooredGrade)
            let emptyStars = String(repeating: "☆", count: 5-flooredGrade)
            
            return filledStars + emptyStars
        } else {
            return String(repeating: "★", count: 5)
        }
    }
}
