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
    
    let passwordTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        return textField
    }()
    
    let nextButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .darkGray
        button.configuration = config
        button.layer.cornerRadius = 8
        return button
    }()
    
    let validationLabel = {
        let label = UILabel()
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
        print(#function)
        let userInput = PublishSubject<String>()
        
        userInput
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        let baseColor = BehaviorSubject<UIColor>(value: .systemRed)
        
        baseColor
            .bind(with: self, onNext: { owner, color in
                owner.passwordTextField.layer.borderColor = color.cgColor
                
            })
            .disposed(by: disposeBag)
        
    }
}
