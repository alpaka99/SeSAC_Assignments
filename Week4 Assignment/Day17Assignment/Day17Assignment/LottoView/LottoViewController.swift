//
//  ViewController.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

class LottoViewController: UIViewController {
    let textField: UITextField = UITextField()
    
    let lottoHeaderView: LottoHeaderView = LottoHeaderView()
    
    let drawPrefixLabel: UILabel = UILabel()
    let drawSuffixLabel: UILabel = UILabel()
    lazy var resultLabelStack: UIStackView = UIStackView(arrangedSubviews: [drawPrefixLabel, drawSuffixLabel])
    let lottoBallsView: LottoBallsView = LottoBallsView()
    let bonusLabel: UILabel = UILabel()
    
    let drawNumberPickerView: UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(lottoHeaderView)
        view.addSubview(resultLabelStack)
        view.addSubview(lottoBallsView)
        view.addSubview(bonusLabel)
        view.addSubview(drawNumberPickerView)
    }

    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.05)
        }
        
        lottoHeaderView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
                .offset(20)
            
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
            
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.05)
        }
        
        resultLabelStack.snp.makeConstraints { make in
            make.top.equalTo(lottoHeaderView.snp.bottom)
                .offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.safeAreaLayoutGuide)
                .multipliedBy(0.5)
        }
        
        lottoBallsView.snp.makeConstraints { make in
            make.top.equalTo(drawPrefixLabel.snp.bottom)
                .offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.05)
        }
        
        
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoBallsView.bonusBall.snp.bottom)
                .offset(4)
            make.centerX.equalTo(lottoBallsView.bonusBall.snp.centerX)
        }
        
        drawNumberPickerView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.3)
        }
    }
    
    func configureUI() {
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.borderWidth = 2
        textField.textAlignment = .center
        
        resultLabelStack.axis = .horizontal
        resultLabelStack.spacing = 8
        resultLabelStack.distribution = .fillEqually
        
        drawPrefixLabel.textAlignment = .right
        drawPrefixLabel.textColor = .systemYellow
        drawPrefixLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        bonusLabel.textAlignment = .center
        bonusLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        drawSuffixLabel.textAlignment = .left
        drawSuffixLabel.textColor = .black
        drawSuffixLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        drawNumberPickerView.delegate = self
        drawNumberPickerView.dataSource = self

    }
    
    func configureData() {
        drawPrefixLabel.text = "913회"
        drawSuffixLabel.text = "당첨번호"
        bonusLabel.text = "보너스"
    }
}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UILabel()
        view.text = "\(row)"
        view.textAlignment = .center
        return view
    }
}
