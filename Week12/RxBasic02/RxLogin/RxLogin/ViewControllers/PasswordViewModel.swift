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
    struct Input {
        let passwordTextFieldInput: ControlProperty<String>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        
        
        return Output(nextButtonTapped: input.nextButtonTapped)
    }
}
