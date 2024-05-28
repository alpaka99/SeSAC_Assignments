//
//  Constants.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit


struct BasicCellInfo {
    static let text: String = "Something went wrong...😞"
}

struct AdBadgeCell {
    static let text: String = "Ad"
}

enum AlertType {
    case restaurantDelete
    
    var title: String {
        switch self {
        case .restaurantDelete:
            return "정말 삭제하실래요?"
        }
    }
    
    var message: String {
        switch self {
        case .restaurantDelete:
            return "삭제된 데이터는 복원되지 않습니다"
        }
    }
}

enum AlertActionType {
    case delete
    case cancel
    
    var title: String {
        switch self {
        case .cancel:
            return "취소"
        case .delete:
            return "삭제"
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .delete:
            return .destructive
        case .cancel:
            return .cancel
        }
    }
}
