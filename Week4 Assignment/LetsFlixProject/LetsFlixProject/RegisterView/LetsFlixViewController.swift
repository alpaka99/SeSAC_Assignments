//
//  ViewController.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

import SnapKit

class LetsFlixViewController: UIViewController {

    let letsFilxTitle: UILabel = LabelType.letsFlixTitle(LabelConstants.letsFlixTitle).build()
    
    let emailTextField: UITextField = TextFieldType.register(TextFieldConstants.emailPlaceholder).build()
    let passwordTextField: UITextField = TextFieldType.register(TextFieldConstants.passwordPlaceholder).build()
    let nicknameTextField: UITextField = TextFieldType.register(TextFieldConstants.nicknamePlaceholder).build()
    let locationTextField: UITextField = TextFieldType.register(TextFieldConstants.locationPlaceholder).build()
    let couponTextField: UITextField = TextFieldType.register(TextFieldConstants.couponTextField).build()
    lazy var letsFlixStack: UIStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nicknameTextField, locationTextField, couponTextField])
    
    let registerButton: UIButton = ButtonType.common(nil, ButtonConstants.registerButtonTitle).build()
    
    
    let bottomLabel: UILabel = LabelType.title(LabelConstants.letsFlixBottomTitle).build()
    let switchButton: UISwitch = UISwitch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureHierarchy()
        
        configureLayouts()
        
        configureUI()
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
    
    private func configureUI() {
        view.backgroundColor = .black
        
        letsFlixStack.axis = .vertical
        letsFlixStack.spacing = 16
        letsFlixStack.distribution = .fillEqually
        
        switchButton.onTintColor = .systemRed
    }
    
    @objc
    func registerButtonTapped(_ sender: UIButton) {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        
        present(tabBarController, animated: true)
    }
}
