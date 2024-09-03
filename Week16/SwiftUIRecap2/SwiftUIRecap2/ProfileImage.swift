//
//  ProfileImage.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import Foundation

enum ProfileImage: CaseIterable {
    case profile0
    case profile1
    case profile2
    case profile3
    case profile4
    case profile5
    case profile6
    case profile7
    case profile8
    case profile9
    case profile10
    case profile11
    
    var imageName: String {
        switch self {
        case .profile0:
            return "profile_0"
        case .profile1:
            return "profile_1"
        case .profile2:
            return "profile_2"
        case .profile3:
            return "profile_3"
        case .profile4:
            return "profile_4"
        case .profile5:
            return "profile_5"
        case .profile6:
            return "profile_6"
        case .profile7:
            return "profile_7"
        case .profile8:
            return "profile_8"
        case .profile9:
            return "profile_9"
        case .profile10:
            return "profile_10"
        case .profile11:
            return "profile_11"
        }
    }
    
    static func randomImage() -> Self {
        if let randomImage = Self.allCases.randomElement() {
            return randomImage
        } else {
            return .profile0
        }
    }
}
