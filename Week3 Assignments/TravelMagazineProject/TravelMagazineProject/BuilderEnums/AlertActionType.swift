//
//  AlertActionType.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit

internal enum AlertActionType {
    case delete
    case cancel
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        case .delete:
            return .destructive
        }
    }
    
    var title: String {
        switch self {
        case .cancel:
            return "취소"
        case .delete:
            return "삭제"
        }
    }
}
