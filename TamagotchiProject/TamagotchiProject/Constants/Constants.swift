//
//  Constants.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

struct Screen {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
}


enum TamagotchiTalk: String, CaseIterable {
    case talk1 = "복습 아직도 안하셨다고요? 지금 잠이 오세요?"
    case talk2 = "테이블 뷰 컨트롤러와 뷰 컨트롤러는 어떤 차이가 있을까요?"
    case talk3 = "오늘 깃허브 푸시 하셨어영?"
    case talk4 = "커밋 푸쉬 커밋 푸쉬 으하하하핳"
    case talk5 = "enum 이놈"
    case talk6 = "잠온다와 졸리다의 차이를 아시나요?"
    case talk7 = "잔디는 물을 주지 않으면 죽어요"
    case talk8 = "나의 사춘기에게 라는 노래를 아시나요?"
    
    var talk: String {
        let userName: String = UserNameManager.shared.userName
        switch self {
        case .talk1:
            return self.rawValue + " \(userName)님"
        case .talk2:
            return self.rawValue
        case .talk3:
            return "\(userName)님 " + self.rawValue
        case .talk4:
            return self.rawValue
        default:
            return self.rawValue
        }
    }
    
    static var randomTamagotchi: Self {
        return Self.allCases.randomElement() ?? Self.talk1
    }
}
