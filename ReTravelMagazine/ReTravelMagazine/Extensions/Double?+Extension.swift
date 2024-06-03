//
//  Double?+Extension.swift
//  ReTravelMagazine
//
//  Created by user on 6/4/24.
//


extension Double? {
    var starGrade: String {
        if let starCount = self {
            let filledStarCount = Int(starCount.rounded())
            let filledStars = String(
                repeating: "★",
                count: filledStarCount
            )
            
            let unFilledStars = String(
                repeating: "☆",
                count: 5-filledStarCount
            )
            
            return filledStars + unFilledStars
        }
        
        return ""
    }
}

