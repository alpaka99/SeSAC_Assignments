//
//  Travel.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

struct Travel {
    let title: String
    let description: String?
    let travel_image: String?
    let grade: Double?
    let save: Double?
    let like: Bool?
    let ad: Bool
    
    var descriptionText: String {
        return ""
    }
    
    var fullGradeDescription: String {
        return "\(grade.starGrade) (\(grade ?? 0.0) • 저장 \(save ?? 0)"
    }
}


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
