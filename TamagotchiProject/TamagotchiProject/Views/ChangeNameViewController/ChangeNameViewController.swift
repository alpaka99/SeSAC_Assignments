//
//  ChangeNameViewController.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//

import UIKit

import SnapKit

final class ChangeNameViewController: UIViewController {
    let textField: UITextField = UITextField()
    let divider: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
}

extension ChangeNameViewController: CodeBaseBuildable {
    func configureData<T>(_ data: T) {
        
    }
    
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(divider)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.snp.width)
                .multipliedBy(0.8)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(44)
        }
        
        divider.snp.makeConstraints {
            $0.width.equalTo(textField.snp.width)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom)
                .offset(4)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .TGBackgroundColor
        
        navigationItem.title = "대장님 이름 정하기"
        let rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        textField.placeholder = "새 대장님의 이름을 알려주세요"
        textField.text = UserNameManager.shared.userName
        divider.backgroundColor = .TGNavyColor
    }
    
    @objc
    func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let userName = textField.text,
           userName.isEmpty == false {
            UserNameManager.shared.setUserNameInfo(userName)
            navigationController?.popViewController(animated: true)
        }
    }
}
