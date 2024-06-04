//
//  ViewController.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

import SnapKit

class LetsFlixViewController: UIViewController {

    let letsFilxTitle: UILabel = LabelType.letsFlixTitle("LETSFLIX").build()
    
    let emailTextField: UITextField = TextFieldType.register("이메일 주소 또는 전화번호").build()
    let passwordTextField: UITextField = TextFieldType.register("비밀번호").build()
    let nicknameTextField: UITextField = TextFieldType.register("닉네임").build()
    let locationTextField: UITextField = TextFieldType.register("위치").build()
    let couponTextField: UITextField = TextFieldType.register("추천 코드 입력").build()
    lazy var letsFlixStack: UIStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nicknameTextField, locationTextField, couponTextField])
    
    let registerButton: UIButton = ButtonType.common("", "회원가입").build()
    
    
    let bottomLabel: UILabel = LabelType.title("추가 정보 입력").build()
    let switchButton: UISwitch = UISwitch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        
        configureLayouts()
        
    }

    
    private func configureHierarchy() {
        view.addSubview(letsFilxTitle)
        view.addSubview(letsFlixStack)
        view.addSubview(registerButton)
        view.addSubview(bottomLabel)
        view.addSubview(switchButton)
    }
    
    private func configureLayouts() {
        configureLetFlixTitleLayout()
        configureTextFieldsLayout()
        configureRegisterButton()
        configureBottomlabel()
        configureSwitchButton()
    }
    
    private func configureLetFlixTitleLayout() {
        letsFilxTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
                .offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func configureTextFieldsLayout() {
        letsFlixStack.axis = .vertical
        letsFlixStack.spacing = 16
        letsFlixStack.distribution = .fillEqually
        letsFlixStack.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(view.snp.width)
                .multipliedBy(0.7)
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.3)
        }
    }
    
    private func configureRegisterButton() {
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(letsFlixStack.snp.bottom)
                .offset(16)
            make.horizontalEdges.equalTo(letsFlixStack.snp.horizontalEdges)
            make.height.equalTo(emailTextField.snp.height)
                .multipliedBy(1.2)
        }
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func configureBottomlabel() {
        bottomLabel.snp.makeConstraints { make in
            make.leading.equalTo(registerButton)
            make.top.equalTo(registerButton.snp.bottom)
                .offset(16)
        }
    }
    
    private func configureSwitchButton() {
        switchButton.snp.makeConstraints { make in
            make.trailing.equalTo(registerButton)
            make.top.equalTo(registerButton.snp.bottom)
                .offset(16)
        }
    }
    
    @objc
    func registerButtonTapped(_ sender: UIButton) {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        
        present(tabBarController, animated: true)
    }
}
