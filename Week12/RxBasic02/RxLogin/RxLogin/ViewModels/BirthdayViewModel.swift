//
//  BirthdayViewModel.swift
//  RxLogin
//
//  Created by user on 8/6/24.
//

import Foundation

import RxCocoa
import RxSwift

final class BirthdayViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let birthDay: ControlProperty<Date>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let year: BehaviorRelay<String>
        let month: BehaviorRelay<String>
        let day: BehaviorRelay<String>
        let labelColor: BehaviorRelay<Color>
        let labelText: BehaviorSubject<String>
        let buttonColor: BehaviorRelay<Color>
        let isEnabled: BehaviorRelay<Bool>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let year = BehaviorRelay<String>(value: "2024")
        let month = BehaviorRelay<String>(value: "8")
        let day = BehaviorRelay<String>(value: "1")
        let labelColor = BehaviorRelay<Color>(value: .red)
        let labelText = BehaviorSubject(value: "")
        let buttonColor = BehaviorRelay<Color>(value: .darkGray)
        let isEnabled = BehaviorRelay<Bool>(value: false)
        let nextButtonTapped = input.nextButtonTapped
        
        input.birthDay
            .map {
                let components = Calendar.current.dateComponents([.year, .month, .day], from: $0)
                return components
            }
            .map {
                let birthdayYear = $0.year ?? 0
                let birthdayMonth = $0.month ?? 0
                let birthdayDay = $0.day ?? 0
                
                let todayDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
                let todayYear = todayDateComponents.year ?? 0
                let todayMonth = todayDateComponents.month ?? 0
                let todayDay = todayDateComponents.day ?? 0
                
                var age = todayYear - birthdayYear
                
                if todayMonth < birthdayMonth {
                    age -= 1
                }
                
                if todayMonth == birthdayMonth, todayDay < birthdayDay {
                    age -= 1
                }
                
                year.accept(String(todayYear)+"년")
                month.accept(String(todayMonth)+"월")
                day.accept(String(todayDay)+"일")
                
                return age
            }
            .map {
                if $0 < 17 {
                    return false
                } else {
                    return true
                }
            }
            .bind(with: self) { owner, flag in
                labelColor.accept(flag ? .green : .red)
                labelText.onNext(flag ? "가입 가능한 나이입니다" : "만 17세 이상 가입 가능합니다.")
                buttonColor.accept(flag ? .blue : .darkGray)
                isEnabled.accept(flag)
            }
            .disposed(by: disposeBag)
        
        return Output(year: year, month: month, day: day, labelColor: labelColor, labelText: labelText, buttonColor: buttonColor, isEnabled: isEnabled, nextButtonTapped: nextButtonTapped)
    }
}
