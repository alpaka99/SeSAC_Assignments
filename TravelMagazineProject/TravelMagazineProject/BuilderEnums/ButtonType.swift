//
//  ButtonType.swift
//  TravelMagazineProject
//
//  Created by user on 5/28/24.
//

import Foundation
import UIKit


// MARK: 고민 - 필요없는것들(e.g 모든 label의 corner radius가 없는데 광고cell의 2개만 cornerRadius와 clipsToMask 프로퍼티가 존재)을 위해서 모든 경우를 다 만들어야하나? 그리고 그러면 필요 없는것들에 대해서 전부 다 해당 연산 프로퍼티를 보면서 연산을 하고, 연산한걸 컴포넌트에 적용하는 일을 하는데 이게 맞는가?
// 확장성이 별로인것 같다고 느껴짐
enum ButtonType: Hashable {
    case favoriteButton(ButtonState)
    case likeButton(ButtonState)
    
    var systemName: String {
        switch self {
        case .favoriteButton(.pressed):
            return "star.fill"
        case .favoriteButton(.normal):
            return "star"
        case .likeButton(.pressed):
            return "heart.fill"
        case .likeButton(.normal):
            return "heart"
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .favoriteButton(.pressed), .likeButton(.pressed):
            return .red
        case .favoriteButton(.normal):
            return .systemBlue
        case .likeButton(.normal):
            return .white
        }
    }
    
    func toggle() -> Self {
        switch self {
        case .favoriteButton(let state):
            return .favoriteButton(state.toggle())
        case .likeButton(let state):
            return .likeButton(state.toggle())
        }
    }
}


enum ButtonState {
    case pressed
    case normal
    
    func toggle() -> Self {
        switch self {
        case .pressed:
            return .normal
        case .normal:
            return .pressed
        }
    }
}
