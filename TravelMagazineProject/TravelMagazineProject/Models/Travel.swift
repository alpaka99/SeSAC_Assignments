//
//  Travel.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//


struct Travel {
    let title: String?
    let description: String?
    let travel_image: String?
    let grade: Double?
    let save: Int?
    let like: Bool?
    let ad: Bool
    
    var gradeLabel: String {
        return "\(grade.getStars()) (\(grade ?? 0)) • 저장 \(save?.formatted() ?? "0")"
    }
    
    var isLike: Bool {
        if let isLike = self.like {
            return isLike
        } else {
            return false
        }
    }
}
