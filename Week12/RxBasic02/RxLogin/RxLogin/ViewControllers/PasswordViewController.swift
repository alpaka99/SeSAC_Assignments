//
//  PasswordViewController.swift
//  RxLogin
//
//  Created by user on 8/2/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class PasswordViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let viewModel = PasswordViewModel()
    
    let userInput = PublishSubject<String>()
    let baseColor = BehaviorSubject<UIColor>(value: .systemRed)
    let passwordValidation = BehaviorSubject(value: "")
    
    let passwordTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        return textField
    }()
    
    let nextButton = AssignmentButton(title: "다음으로")
    
    let validationLabel = {
        let label = UILabel()
        label.text = "비밀번호를 4자리 이상 입력해주세요"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureBind()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(passwordTextField)
        view.addSubview(validationLabel)
        view.addSubview(nextButton)
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        validationLabel.snp.makeConstraints { label in
            label.top.equalTo(passwordTextField.snp.bottom)
                .offset(20)
            label.horizontalEdges.equalTo(passwordTextField)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(validationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    
    func configureBind() {
        let input = PasswordViewModel.Input(passwordTextFieldInput: passwordTextField.rx.text.orEmpty, nextButtonTapped: nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        
        // output
//        let a = userInput
//        a
//            .bind(to: passwordTextField.rx.text)
//            .disposed(by: disposeBag)
        
        // output
//        baseColor
//            .bind(with: self, onNext: { owner, color in
//                owner.passwordTextField.layer.borderColor = color.cgColor
//                
//            })
//            .disposed(by: disposeBag)
//        
        
        // input
//        passwordTextField.rx.text.orEmpty // orEmpty를 안쓰면 ControlProperty<String?>인 optional type이라서 에러가 발생함
//            .bind(to: passwordValidation)
//            .disposed(by: disposeBag)
        
//        let a = passwordValidation
        
        
        // output
//        passwordValidation
//            .map { $0.count >= 4 }
//            .bind(with: self) { owner, flag in
//                owner.nextButton.rx.isEnabled.onNext(flag)
//                owner.validationLabel.rx.isHidden.onNext(flag)
//                let color = flag ? UIColor.systemGreen : UIColor.systemRed
//                owner.nextButton.rx.backgroundColor.onNext(color)
//                owner.passwordTextField.layer.rx.borderColor.onNext(color.cgColor)
//            }
//            .disposed(by: disposeBag)
        
        
        // input
        output.nextButtonTapped.subscribe(with: self) { owner, _ in
            owner.navigationController?.pushViewController(PhoneViewController(), animated: true)
        }
            .disposed(by: disposeBag)
    }
}
