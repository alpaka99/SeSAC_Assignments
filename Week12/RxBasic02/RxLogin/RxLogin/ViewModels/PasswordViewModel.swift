//
//  PasswordViewModel.swift
//  RxLogin
//
//  Created by user on 8/5/24.
//

import Foundation

import RxCocoa
import RxSwift

final class PasswordViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let passwordTextFieldInput: ControlProperty<String>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let nextButtonTapped: ControlEvent<Void>
        let baseColor: BehaviorSubject<Color>
        let isValid: BehaviorSubject<Bool>
    }
    
    func transform(input: Input) -> Output {
        let baseColor = BehaviorSubject(value: Color.red)
        let isValid = BehaviorSubject(value: false)
        
        input.passwordTextFieldInput
            .map { $0.count >= 4 }
            .bind(with: self) { owner, flag in
                
                isValid.onNext(flag)
                
                baseColor.onNext(flag ? Color.green : Color.red)
                
            }
            .disposed(by: disposeBag)
        
        
        return Output(nextButtonTapped: input.nextButtonTapped, baseColor: baseColor, isValid: isValid)
    }
}
