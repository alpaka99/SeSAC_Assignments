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
    
    let viewModel = PhoneViewModel()
    
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
        let input = PhoneViewModel.Input(textfieldInput: phoneTextField.rx.text.orEmpty, nextButtonTapped: nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        // output
        output.phoneNumber
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        // input
        phoneTextField.rx.text.orEmpty
            .bind(to: input.textfieldInput)
            .disposed(by: disposeBag)
        
        
        output.isEnabled
            .bind(with: self) { owner, value in
                owner.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        output.validationText
            .bind(with: self) { owner, text in
                owner.validationLabel.rx.text
                    .onNext(text)
            }
            .disposed(by: disposeBag)
        
        output.baseColor
            .bind(with: self) { owner, color in
                owner.validationLabel.rx.textColor
                    .onNext(color.asUIColor)
                owner.nextButton.rx.backgroundColor
                    .onNext(color.asUIColor)
            }
            .disposed(by: disposeBag)
        
        
        // output
//        baseColor
//            .bind(to: nextButton.rx.backgroundColor)
//            .disposed(by: disposeBag)
        
        // output
        
        output.nextButtonTapped
            .bind(with: self, onNext: { owner, _ in
                owner.navigationController?.pushViewController(BirthdayViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
