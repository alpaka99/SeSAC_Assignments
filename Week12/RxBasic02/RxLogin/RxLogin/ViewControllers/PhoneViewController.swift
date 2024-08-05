//
//  PhoneViewController.swift
//  RxLogin
//
//  Created by user on 8/4/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class PhoneViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let phoneTextField = AssignmentTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = AssignmentButton(title: "다음")
    let validationLabel = {
        let label = UILabel()
        label.text = "알맞은 전화번호 형태를 입력해주세요"
        return label
    }()
    
    let phoneNumber = BehaviorSubject(value: "010")
    let phoneNumberValidation = PublishSubject<Bool>()
    let baseColor = BehaviorSubject(value: UIColor.systemRed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        configureBind()
    }

    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(phoneTextField)
        view.addSubview(validationLabel)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { textField in
            textField.height.equalTo(50)
            textField.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            textField.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        validationLabel.snp.makeConstraints { label in
            label.height.equalTo(50)
            label.top.equalTo(phoneTextField.snp.bottom).offset(30)
            label.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { btn in
            btn.height.equalTo(50)
            btn.top.equalTo(validationLabel.snp.bottom).offset(30)
            btn.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureBind() {
        phoneNumber
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        phoneTextField.rx.text.orEmpty
            .map {[weak self] in
                if $0.count > 11 { // 11 글자 이상 입력 못하게 자동 처리
                    let startIndex = $0.index($0.startIndex, offsetBy: 0)
                    let endRange = $0.index(startIndex, offsetBy: 10)
                    let subString =  String($0[startIndex...endRange])
                    
                    self?.phoneTextField.text = subString
                    return subString
                } else {
                    return $0
                }
            }
            .map {
                if $0.count == 11, let _ = Int($0) {
                    return true
                } else {
                    return false
                }
            }
            .bind(with: self) { owner, value in
                owner.baseColor.onNext(value ? .systemGreen : .systemRed)
                owner.nextButton.isEnabled = value
                owner.validationLabel.text = value ? "확인되었습니다 :D" : "올바른 형태의 전화번호를 입력해주세요"
                owner.validationLabel.textColor = value ? .systemGreen : .systemRed
            }
            .disposed(by: disposeBag)
        
        
        baseColor
            .bind(to: nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe { _ in
                
            }
            .disposed(by: disposeBag)
    }
}
