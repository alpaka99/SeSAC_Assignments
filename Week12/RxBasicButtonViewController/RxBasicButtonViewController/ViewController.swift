//
//  ViewController.swift
//  RxBasicButtonViewController
//
//  Created by user on 7/30/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {
    var firstButtonCount = 0
    
    let disposeBag = DisposeBag()
    
    let firstTextLabel = {
        let label = UILabel()
        label.text = "before input"
        label.backgroundColor = .magenta
        return label
    }()
    let firstButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .systemOrange
        config.cornerStyle = .capsule
        config.title = "첫번째 버튼"
        button.configuration = config
        button.tintColor = .white
        return button
    }()
    
    let reactiveTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBlue
        return textField
    }()
    let secondButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .systemGreen
        config.cornerStyle = .capsule
        config.title = "두번째 버튼"
        button.configuration = config
        button.tintColor = .white
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        reactiveProgramming()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(firstTextLabel)
        view.addSubview(firstButton)
        view.addSubview(reactiveTextField)
        view.addSubview(secondButton)
        
        
        firstTextLabel.snp.makeConstraints { label in
            label.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            label.height.equalTo(40)
        }
        firstButton.snp.makeConstraints { btn in
            btn.top.equalTo(firstTextLabel.snp.bottom)
                .offset(16)
            btn.centerX.equalTo(view.snp.centerX)
            btn.height.equalTo(44)
        }
        
        reactiveTextField.snp.makeConstraints { textField in
            textField.top.equalTo(firstButton.snp.bottom)
                .offset(100)
            textField.horizontalEdges.equalTo(firstTextLabel.safeAreaLayoutGuide)
            textField.height.equalTo(44)
        }
        secondButton.snp.makeConstraints { btn in
            btn.top.equalTo(reactiveTextField.snp.bottom)
                .offset(16)
            btn.horizontalEdges.equalTo(firstButton.snp.horizontalEdges)
        }
    }

    func reactiveProgramming() {
        firstButton.rx.tap
            .map { [weak self] in self?.firstButtonCount += 1 }
            .map { [weak self] in
                if let vc = self {
                    "\(vc.firstButtonCount)번 탭 했어요"
                } else {
                    ""
                }
            }
            .bind(to: firstTextLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

