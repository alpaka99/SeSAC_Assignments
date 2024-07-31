//
//  SimpleValidationViewController.swift
//  RxBasicButtonViewController
//
//  Created by user on 8/1/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SimpleValidationViewController:
    UIViewController {
    let disposeBag = DisposeBag()
    
    let usernameTextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.placeholder = "닉네임을 입력해주세요"
        return textField
    }()
    let userValidationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemRed
        label.text = "닉네임은 최소 5글자 이상이어야합니다"
        return label
    }()
    let passwordTextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.placeholder = "비밀번호를 입력해주세요"
        return textField
    }()
    let passwordValidationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemRed
        label.text = "비밀번호는 최소 5글자 이상이어야합니다"
        return label
    }()
    let submitButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .systemBlue
        config.title = "제출하기"
        button.configuration = config
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureRx()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(usernameTextField)
        view.addSubview(userValidationLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidationLabel)
        view.addSubview(submitButton)
        
        usernameTextField.snp.makeConstraints { textField in
            textField.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            textField.height.equalTo(44)
        }
        userValidationLabel.snp.makeConstraints { label in
            label.top.equalTo(usernameTextField.snp.bottom)
                .offset(8)
            label.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
        passwordTextField.snp.makeConstraints { textField in
            textField.top.equalTo(userValidationLabel.snp.bottom)
                .offset(16)
            textField.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            textField.height.equalTo(44)
        }
        passwordValidationLabel.snp.makeConstraints { label in
            label.top.equalTo(passwordTextField.snp.bottom)
                .offset(8)
            label.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
        submitButton.snp.makeConstraints { btn in
            btn.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            btn.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            btn.height.equalTo(48)
            btn.top.greaterThanOrEqualTo(passwordValidationLabel.snp.bottom)
                .offset(100)
        }
    }
    
    
    func configureRx() {
        BehaviorSubject.just("")
            .bind(to: usernameTextField.rx.text)
            .disposed(by: disposeBag)
        
        BehaviorSubject.just("")
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count > 5 }
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count > 5 }
        
        usernameValid
            .bind(to: userValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        let readyToSubmit = BehaviorSubject.combineLatest(usernameValid, passwordValid)
            .map { $0 && $1 }
            
        readyToSubmit
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let ac = UIAlertController(title: "RxBasic", message: "UserInfo Submitted", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Wow!", style: .default))
        
        present(ac, animated: true)
    }
}
