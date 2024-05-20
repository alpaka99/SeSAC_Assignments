//
//  RegisterViewController.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

final class RegisterViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var personalInfoTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var couponNumberTextField: UITextField!
    
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // mainLabel
        setTitleLabel()
        
        // textFields
        setTextFields()
        
        // button
        setRegisterButton()
        
        // bottomLabels
        setBottomLabels()
    }
    
    private func setTitleLabel() {
        titleLabel.text = RegisterConstants.titleLabelText
        titleLabel.textColor = .red
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        titleLabel.textAlignment = .center
    }
    
    private func setTextFields() {
        let textFields: [InfoType] = InfoType.allCases
        
        textFields.forEach { textField in
            switch textField {
            case .personalInfo:
                setTextField(
                    personalInfoTextField,
                    infoType: .personalInfo
                )
            case .password:
                setTextField(
                    passwordTextField,
                    infoType: .password
                )
            case .nickname:
                setTextField(
                    nicknameTextField,
                    infoType: .nickname
                )
            case .location:
                setTextField(
                    locationTextField,
                    infoType: .location
                )
            case .couponNumber:
                setTextField(
                    couponNumberTextField,
                    infoType: .couponNumber
                )
            case .enabled:
                break
            }
        }
    }
    
    private func setAttributedString(_ infoType: InfoType) -> NSAttributedString {
        let placeholder = infoType.rawValue
        
        let attributedString = NSAttributedString(
            string: placeholder,
            attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            )
        ])
        
        return attributedString
    }
    
    private func setTextField(
        _ textField: UITextField,
        infoType: InfoType
    ) {
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.attributedPlaceholder = setAttributedString(infoType)
        
        if infoType == .password {
            textField.isSecureTextEntry = true
        }
    }
    
    private func setRegisterButton() {
        registerButton.addTarget(
            self,
            action: #selector(registerButtonTapped),
            for: .touchUpInside
        )
        
        disableRegisterButton(InfoType.personalInfo.disabledReson())
        registerButton.isEnabled = false
    }
    
    private func enableRegisterButton() {
        registerButton.backgroundColor = .white
        let attributedString = NSAttributedString(
            string: RegisterConstants.registerButtonTitle,
            attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ])
        registerButton.setAttributedTitle(attributedString, for: .normal)
        registerButton.layer.cornerRadius = 8
        registerButton.tintColor = .black
        registerButton.isEnabled = true
    }
    
    private func disableRegisterButton(_ disableReason: String) {
        
        registerButton.backgroundColor = .white
        let attributedString = NSAttributedString(string: disableReason, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(
                ofSize: 12,
                weight: .bold
            ),
            NSAttributedString.Key.foregroundColor : UIColor.darkGray
        ])
        registerButton.setAttributedTitle(attributedString, for: .normal)
        registerButton.layer.cornerRadius = 8
        registerButton.backgroundColor = .gray
        registerButton.isEnabled = false
    }
    
    @objc private func registerButtonTapped() {
        UIApplication.shared.resignFirstResponder()
    }
    
    private func setBottomLabels() {
        bottomLabel.text = RegisterConstants.bottomLabelText
        bottomLabel.textColor = .white
        
        switchButton.onTintColor = .systemRed
    }
    
    private func checkButtonDisabled() -> InfoType {
        guard checkPersonalInfo() else { return .personalInfo }
        guard checkPassword() else { return .password }
        guard checkNickname() else { return .nickname }
        guard checkCouponNumber() else { return .couponNumber }
        
        return .enabled
    }
    
    private func checkPersonalInfo() -> Bool {
        guard let personalInfo = personalInfoTextField.text else { return false }
        guard !personalInfo.isEmpty else { return false }
        return true
    }
    
    private func checkPassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        guard password.count >= 6 else { return false }
        return true
    }
    
    private func checkNickname() -> Bool {
        guard let nickname = nicknameTextField.text else { return false }
        guard !nickname.isEmpty else { return false }
        return true
    }
    
    private func checkCouponNumber() -> Bool {
        if let couponNumber = couponNumberTextField.text {
            if couponNumber.isEmpty {
                return true
            }
            
            if Int(couponNumber) == nil {
                return false
            }
        }
        return true
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let checkResult = checkButtonDisabled()
        switch checkResult {
        case .enabled:
            enableRegisterButton()
        default:
            disableRegisterButton(checkResult.disabledReson())
        }
    }
}

// combine two enums into one
fileprivate enum InfoType: String, CaseIterable {
    case personalInfo = "이메일 주소 또는 전화번호"
    case password = "비밀번호"
    case nickname = "닉네임"
    case location = "위치"
    case couponNumber = "추천코드 입력"
    case enabled = "허가됨"

    func disabledReson() -> String {
        switch self {
        case .personalInfo:
            RegisterConstants.personalDisableReason
        case .password:
            RegisterConstants.passwordDisableReason
        case .nickname:
            RegisterConstants.nicknameDisableReason
        case .location:
            RegisterConstants.locationDisableReason
        case .couponNumber:
            RegisterConstants.couponNumberDisableReason
        case .enabled:
            RegisterConstants.enabledReason
        }
    }
}
