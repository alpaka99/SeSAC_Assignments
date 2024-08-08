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
        
        
        output.baseColor
            .bind(with: self) { owner, color in
                owner.passwordTextField.layer.rx.borderColor.onNext(color.asUIColor.cgColor)
                owner.nextButton.rx.backgroundColor.onNext(color.asUIColor)
                owner.validationLabel.rx.textColor.onNext(color.asUIColor)
            }
            .disposed(by: disposeBag)
        
        output.isValid
            .bind(with: self) { owner, flag in
                owner.validationLabel.rx.isHidden.onNext(flag)
            }
            .disposed(by: disposeBag)
        
        // input
        output.nextButtonTapped.subscribe(with: self) { owner, _ in
            owner.navigationController?.pushViewController(PhoneViewController(), animated: true)
        }
            .disposed(by: disposeBag)
    }
}
