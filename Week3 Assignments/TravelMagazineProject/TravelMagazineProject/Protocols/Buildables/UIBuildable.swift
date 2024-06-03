//
//  UIBuildable.swift
//  TravelMagazineProject
//
//  Created by user on 5/28/24.
//

import Foundation
import UIKit


// MARK: 아직 고민중...
// 최종적으로 하고싶은것
// buildTypes를 돌면서 해당하는 builder들이 자동으로 착착 해주는거를 하고 싶다...

protocol Buildable {
    var builders: [BuilderType] { get set }
    
    func fetchBuilders()
}

extension Buildable {
    func fetchBuilders() {
        self.builders.forEach { builder in
            // ... 이제 어쩌지 builder를 반환하고 buildUI() 함수같은걸 공통으로 만들어놓고 실행시킬까..?
//            switch builder {
//                
//            case .label:
//                <#code#>
//            case .button:
//                <#code#>
//            case .image:
//                <#code#>
//            }
        }
    }
}

enum BuilderType {
    case label
    case button
    case image
}

//class SomeType: Buildable {
//    let builders: [BuilderType] = []
//}
