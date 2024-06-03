//
//  AlertType.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//


internal enum AlertType {
    case restaurantDelete
    
    var message: String {
        switch self {
        case .restaurantDelete:
            return "삭제된 데이터는 복원되지 않습니다"
        }
    }
    
    var title: String {
        switch self {
        case .restaurantDelete:
            return "정말 삭제하실래요?"
        }
    }
}
