//
//  PhoneViewModel.swift
//  RxLogin
//
//  Created by user on 8/6/24.
//

import Foundation

import RxCocoa
import RxSwift

final class PhoneViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let textfieldInput: ControlProperty<String>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let phoneNumber: BehaviorSubject<String>
        let isEnabled: BehaviorSubject<Bool>
        let baseColor: BehaviorSubject<Color>
        let validationText: BehaviorSubject<String>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let phoneNumber = BehaviorSubject(value: "010")
        let isEnabled = BehaviorSubject(value: false)
        let baseColor =  BehaviorSubject(value: Color.red)
        let validationText = BehaviorSubject(value: "")
        let nextButtonTapped = input.nextButtonTapped
        
        input.textfieldInput
            .map {
                if $0.count > 11 { // 11 글자 이상 입력 못하게 자동 처리
                    let startIndex = $0.index($0.startIndex, offsetBy: 0)
                    let endRange = $0.index(startIndex, offsetBy: 10)
                    let subString =  String($0[startIndex...endRange])
                    
                    phoneNumber.onNext(subString)
                    return subString
                } else {
                    return $0
                }
            }
            .map {
                if $0.count == 11, let _ = Int($0) {
                    return true
                } else {
                    return false
                }
            }
            .bind(to: isEnabled)
            .disposed(by: disposeBag)
        
        isEnabled
            .share()
            .bind(with: self) { owner, flag in
                baseColor.onNext(flag ? .green : .red)
                validationText.onNext(flag ? "확인되었습니다 :D" : "올바른 형태의 전화번호를 입력해주세요")
            }
            .disposed(by: disposeBag)
        
        return Output(
            phoneNumber: phoneNumber,
            isEnabled: isEnabled,
            baseColor: baseColor,
            validationText: validationText,
            nextButtonTapped: nextButtonTapped
        )
    }
}
