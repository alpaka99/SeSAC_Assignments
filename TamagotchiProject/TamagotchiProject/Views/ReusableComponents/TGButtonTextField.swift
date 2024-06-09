//
//  TGButtonTextField.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//

import UIKit

import SnapKit

final class TGButtonTextField: UIView {
    let textField: UITextField = UITextField()
    let divider: UIView = UIView()
    let button: UIButton = UIButton()
    var type: TGButtonTextFieldType = .food {
        didSet {
            changeUI()
        }
    }
    
    weak var delegate: TGButtonTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TGButtonTextField: CodeBaseBuildable {
    func configureHierarchy() {
        self.addSubview(textField)
        self.addSubview(divider)
        self.addSubview(button)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints {
            $0.top.leading.equalTo(self)
                .offset(4)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.7)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom)
                .offset(4)
            $0.leading.equalTo(textField.snp.leading)
                .offset(4)
            $0.width.equalTo(textField.snp.width)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(textField.snp.top)
            $0.bottom.equalTo(divider.snp.bottom)
            $0.leading.equalTo(divider.snp.trailing)
                .offset(8)
            $0.trailing.equalTo(self.snp.trailing)
                .offset(-4)
        }
    }
    
    func configureUI() {
        textField.placeholder = "Test"
        textField.textAlignment = .center
        divider.backgroundColor = .TGNavyColor
        
        
        button.setTitleColor(.TGNavyColor, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.TGNavyColor.cgColor
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configureData(_ data: TGButtonTextFieldType) {
        type = data
    }
    
    private func changeUI() {
        switch type {
        case .food:
            textField.placeholder = "밥 주세요"
            button.setTitle("밥", for: .normal)
        case .water:
            textField.placeholder = "물 주세요"
            button.setTitle("물", for: .normal)
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        if let text = textField.text {
            if let amount = Int(text) {
                print(amount)
                if amount < 100 {
                    delegate?.textFieldButtonTapped(type, amount: amount)
                }
            } else {
                delegate?.textFieldButtonTapped(type, amount: 1)
            }
        }
    }
}

protocol TGButtonTextFieldDelegate: AnyObject {
    func textFieldButtonTapped(_ type: TGButtonTextFieldType, amount: Int)
}


/*
 MARK: 내 생각
 데이터를 모든 viewController나 view들이 갖고 있어야할 필요가 있나?
 하나의 객체가 데이터들을 갖고 있고, 변경이 있으면 관찰하고 있는 객체들의 변화를 trigger 하는 방법은 없을까??
 
 왜냐하면 delegate는 하나의 depth만 타고 내려가게 하고 싶음
 
 구현 생각:
 1. TamagotchiStore가 있고
 2. 여기에 각각의 viewController들이 addObserver를 하는것
 3. TamagotchiStore의 내부 변수에 변동이 생기면 didSet으로 NotificationCenter에 publish
 4. 그러면 각 viewController가 받아서 스스로들의 상태를 변경
 
 -> 일단 다 구현하고 리펙터링 해보자
 
 */
