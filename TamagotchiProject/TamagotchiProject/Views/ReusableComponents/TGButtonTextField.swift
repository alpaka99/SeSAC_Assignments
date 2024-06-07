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
        
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.TGNavyColor, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.TGNavyColor.cgColor
        button.layer.cornerRadius = 4
    }
}
