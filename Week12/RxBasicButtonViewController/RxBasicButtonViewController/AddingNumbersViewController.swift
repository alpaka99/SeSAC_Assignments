//
//  AddingNumbersViewController.swift
//  RxBasicButtonViewController
//
//  Created by user on 7/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class AddingNumbersViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let number1 = {
        let textField = UITextField()
        textField.backgroundColor = .systemOrange
        return textField
    }()
    let number2 = {
        let textField = UITextField()
        textField.backgroundColor = .systemBlue
        return textField
    }()
    let number3 = {
        let textField = UITextField()
        textField.backgroundColor = .systemIndigo
        return textField
    }()
    let divider = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    let result = {
        let label = UILabel()
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureRx()
    }
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(divider)
        view.addSubview(result)
        
        number1.snp.makeConstraints { textField in
            textField.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            textField.height.equalTo(44)
        }
        
        number2.snp.makeConstraints { textField in
            textField.top.equalTo(number1.snp.bottom)
                .offset(16)
            textField.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            textField.height.equalTo(44)
        }
        
        number3.snp.makeConstraints { textField in
            textField.top.equalTo(number2.snp.bottom)
                .offset(16)
            textField.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            textField.height.equalTo(44)
        }
        divider.snp.makeConstraints { view in
            view.top.equalTo(number3.snp.bottom)
                .offset(16)
            view.horizontalEdges.equalTo(number1.snp.horizontalEdges)
            view.height.equalTo(1)
        }
        result.snp.makeConstraints { label in
            label.top.equalTo(divider.snp.bottom)
                .offset(16)
            label.horizontalEdges.equalTo(divider.snp.horizontalEdges)
        }
    }
    
    func configureRx() {
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
}
