//
//  Constants.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

internal struct RegisterConstants {
    // view constants
    static let titleLabelText: String = "JACKFLIX"
    static let registerButtonTitle: String = "회원가입"
    static let bottomLabelText: String = "추가 정보 입력"
    
    // TextFieldType constants
    static let personalDisableReason: String = "이메일 혹은 전화번호를 입력해주세요"
    static let passwordDisableReason: String =
    "비밀번호는 숫자로 입력해주세요"
    static let nicknameDisableReason: String =
    "닉네임을 입력해주세요"
    static let locationDisableReason: String =
    "장소를 입력해주세요"
    static let couponNumberDisableReason: String =
    "쿠폰 번호는 숫자로만 이루어져 있습니다."
    static let enabledReason: String =
    "허가됨"
}


internal struct DetailConstants {
    // detail label constants
    static let initialDetailLabelText: String = "당신의 현재 감정은"
    static let endDetailLabelText: String = "\n입니다...!"
    
    // button image constants
    static let buttonConfigurationImageName: String = "arrow.clockwise"
    
    // navigation constants
    static let title: String = "상세 페이지"
    
    // detail view storyboard identifier
    static let identifier: String = "DetailViewController"
}

internal struct EmotionDiaryConstants {
    // image constants
    static let backgroundImageName: String = "paperBackground"
    static let smileButtonImageName: String = "slime1"
    static let happyButtonImageName: String = "slime2"
    static let loveButtonImageName: String = "slime3"
    static let angryButtonImageName: String = "slime4"
    static let sosoButtonImageName: String = "slime5"
    static let sleepyButtonImageName: String = "slime6"
    static let embarrasedButtonImageName: String = "slime7"
    static let unHappyButtonImageName: String = "slime8"
    static let cryButtonImageName: String = "slime9"
    
    // navigation bar constants
    static let navigationTitle: String = "감정 다이어리"
    static let leftBarButtonImageName: String = "list.bullet"
    
    // tab bar constants
    static let tabItemTitle: String = "Emotion"
    static let tabBarItemImageName: String = "face.smiling.inverse"
}

internal struct NewlyCoinedWordConstants {
    // tab bar constants
    static let tabBarTitle: String = "MZ Language"
    static let tabBarItemImageName: String = "magnifyingglass.circle.fill"
    
    // textfield constants
    static let placeholder: String = "어떤 신조어가 궁금하신가요..?"
    static let searchButtonImageName: String = "magnifyingglass"
    
    // imageview constants
    static let imageViewBackgroundImageName: String = "background"
    
    // result label constants
    static let initialLabelText: String = "신조어를 검색해보세요!"
    
    // MZWord enum constants
    static let 디토Value: String = "동의합니다"
    static let kijulValue: String = "너무 재밌어서 기절하겠다"
    static let 중꺾그마Value: String = "중요한건 꺾였는데도 그냥 하는 마음"
    static let ㄱㅂㅈㄱValue: String = "가보자고"
    static let 그잡채Value: String = "가보자고"
    static let h워얼vValue: String = "180도 회정시켜 보면 \'사랑해\'"
    static let 내또출Value: String = "내일 또 출근이야"
    static let 일며들다Value: String = "일이 내 삶에 스며들었다"
    static let 당모치Value: String = "당연히 모든 치킨은 옳다"
    static let 잼얘Value: String = "재밋는 이야기"
    static let 군싹Value: String = "군침이 싹 도네"
    static let sbnValue: String = "선배님"
}
