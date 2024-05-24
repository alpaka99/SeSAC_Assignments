//
//  RegisterViewController.swift
//  Day3Assignment
//
//  Created by user on 5/16/24.
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
        titleLabel.text = "JACKFLIX"
        titleLabel.textColor = .systemRed
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        titleLabel.textAlignment = .center
    }
    
    private func setTextFields() {
        let textFields: [TextFieldType] = TextFieldType.allCases
        
        textFields.forEach { textField in
            switch textField {
            case .personalInfo:
                setTextField(
                    personalInfoTextField,
                    textFieldType: .personalInfo
                )
            case .password:
                setTextField(
                    passwordTextField,
                    textFieldType: .password
                )
            case .nickname:
                setTextField(
                    nicknameTextField,
                    textFieldType: .nickname
                )
            case .location:
                setTextField(
                    locationTextField,
                    textFieldType: .location
                )
            case .couponNumber:
                setTextField(
                    couponNumberTextField,
                    textFieldType: .couponNumber
                )
            }
        }
    }
    
    private func setAttributedString(_ textFieldType: TextFieldType) -> NSAttributedString {
        let placeholder = textFieldType.rawValue
        
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
        textFieldType: TextFieldType
    ) {
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.attributedPlaceholder = setAttributedString(textFieldType)
        
        if textFieldType == .password {
            textField.isSecureTextEntry = true
        }
    }
    
    private func setRegisterButton() {
        registerButton.addTarget(
            self,
            action: #selector(registerButtonTapped),
            for: .touchUpInside
        )
        
        disableRegisterButton(CheckResultType.personalInfo.disabledReson())
        registerButton.isEnabled = false
    }
    
    private func enableRegisterButton() {
        registerButton.backgroundColor = .white
        let attributedString = NSAttributedString(string: "회원가입", attributes: [
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
        bottomLabel.text = "추가 정보 입력"
        bottomLabel.textColor = .white
        
        switchButton.onTintColor = .systemRed
    }
    
    private func checkButtonDisabled() -> CheckResultType {
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

fileprivate enum TextFieldType: String, CaseIterable {
    case personalInfo = "이메일 주소 또는 전화번호"
    case password = "비밀번호"
    case nickname = "닉네임"
    case location = "위치"
    case couponNumber = "추천코드 입력"
}

fileprivate enum CheckResultType {
    case personalInfo
    case password
    case nickname
    case location
    case couponNumber
    case enabled
    
    func disabledReson() -> String {
        switch self {
        case .personalInfo:
            "이메일 혹은 전화번호를 입력해주세요"
        case .password:
            "비밀번호는 숫자로 입력해주세요"
        case .nickname:
            "닉네임을 입력해주세요"
        case .location:
            "장소를 입력해주세요"
        case .couponNumber:
            "쿠폰 번호는 숫자로만 이루어져 있습니다."
        case .enabled:
            "허가됨"
        }
    }
}
