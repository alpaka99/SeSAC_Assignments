//
//  BirthdayViewController.swift
//  RxLogin
//
//  Created by user on 8/4/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class BirthdayViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let year = BehaviorRelay<Int>(value: 2024)
    let month = BehaviorRelay<Int>(value: 8)
    let day = BehaviorRelay<Int>(value: 1)
    let labelColor = BehaviorRelay<UIColor>(value: .systemRed)
    let buttonColor = BehaviorRelay<UIColor>(value: .darkGray)
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = UIColor.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = UIColor.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = UIColor.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = AssignmentButton(title: "가입하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureLayout()
        
        bind()
    }
    
    func bind() {
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                
            }
            .disposed(by: disposeBag)
        
        birthDayPicker.rx.date
            .bind(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                
                
                owner.year.accept(component.year ?? 0)
                owner.month.accept(component.month ?? 0)
                owner.day.accept(component.day ?? 0)
            }
            .disposed(by: disposeBag)
        
        birthDayPicker.rx.date
            .map {
                let components = Calendar.current.dateComponents([.year, .month, .day], from: $0)
                return components
            }
            .map {
                let birthdayYear = $0.year ?? 0
                let birthdayMonth = $0.month ?? 0
                let birthdayDay = $0.day ?? 0
                
                let todayDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
                let todayYear = todayDateComponents.year ?? 0
                let todayMonth = todayDateComponents.month ?? 0
                let todayDay = todayDateComponents.day ?? 0
                
                var age = todayYear - birthdayYear
                
                if todayMonth < birthdayMonth {
                    age -= 1
                }
                
                if todayMonth == birthdayMonth, todayDay < birthdayDay {
                    age -= 1
                }
                
                return age
            }
            .map {
                if $0 < 17 {
                    return false
                } else {
                    return true
                }
            }
            .bind(with: self) { owner, flag in
                owner.labelColor.accept(flag ? .systemGreen : .systemRed)
                owner.infoLabel.text = flag ? "가입 가능한 나이입니다" : "만 17세 이상 가입 가능합니다."
                owner.buttonColor.accept(flag ? .systemBlue : .systemRed)
                owner.nextButton.isEnabled = flag
                
            }
            .disposed(by: disposeBag)
        
        // year가 yearLabel에 표시되는 것이 실패될 리가 없음
        // 그래서 complete, error를 처리할 필요가 없는 bind를 씀
        year
            .map { "\($0)년" }
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        month
            .map { "\($0)월" }
            .bind(to: monthLabel.rx.text)
            .disposed(by: disposeBag)
        day
            .map { "\($0)일" }
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        labelColor
            .bind(to: infoLabel.rx.textColor)
            .disposed(by: disposeBag)
        buttonColor
            .bind(to: nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }

    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    
    func showAlert() {
        let ac = UIAlertController(title: "Rx", message: "is Awsome...!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK!", style: .default))
        present(ac, animated: true)
    }
}

