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
    
    let viewModel = BirthdayViewModel()
    
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
        let input = BirthdayViewModel.Input(birthDay: birthDayPicker.rx.date, nextButtonTapped: nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.labelText
            .bind(to: infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.labelColor
            .bind(with: self) { owner, color in
                owner.infoLabel.rx.textColor.onNext(color.asUIColor)
            }
            .disposed(by: disposeBag)
        
        output.isEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.buttonColor
            .bind(with: self) { owner, color in
                owner.nextButton.rx.backgroundColor.onNext(color.asUIColor)
            }
            .disposed(by: disposeBag)
        
        // year가 yearLabel에 표시되는 것이 실패될 리가 없음
        // 그래서 complete, error를 처리할 필요가 없는 bind를 씀
        
        // output
        output.year
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        output.month
            .bind(to: monthLabel.rx.text)
            .disposed(by: disposeBag)
        output.day
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)

        output.nextButtonTapped
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

