//
//  ViewController.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import Alamofire

final class LottoViewController: UIViewController {
    private let textField: UITextField = UITextField()
    
    private let lottoHeaderView: LottoHeaderView = LottoHeaderView()
    
    private let drawPrefixLabel: UILabel = UILabel()
    private let drawSuffixLabel: UILabel = UILabel()
    private lazy var resultLabelStack: UIStackView = UIStackView(arrangedSubviews: [drawPrefixLabel, drawSuffixLabel])
    private let lottoBallsView: LottoBallsView = LottoBallsView()
    private let bonusLabel: UILabel = UILabel()
    
    private let drawNumberPickerView: UIPickerView = UIPickerView()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(lottoHeaderView)
        view.addSubview(resultLabelStack)
        view.addSubview(lottoBallsView)
        view.addSubview(bonusLabel)
        view.addSubview(drawNumberPickerView)
    }

    private func configureLayout() {
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
            make.top.equalTo(lottoBallsView.snp.bottom)
                .offset(4)
            make.trailing.equalTo(lottoBallsView.snp.trailing)
                .inset(4)
        }
        
        drawNumberPickerView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.3)
        }
    }
    
    private func configureUI() {
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.borderWidth = 2
        textField.textAlignment = .center
        textField.text = "986"
        textField.addTarget(self, action: #selector(textFieldSubmitted), for: .editingDidEndOnExit)
        
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
        
        drawNumberPickerView.backgroundColor = .systemGray3
        drawNumberPickerView.selectRow(985, inComponent: 0, animated: true)

    }
    
    private func configureData(_ data: LottoInfo) {
        drawPrefixLabel.text = "\(data.drwNo)회"
        
        drawSuffixLabel.text = "당첨 번호"
        bonusLabel.text = "보너스"
        
        lottoHeaderView.configureData(data)
        lottoBallsView.configureData(data)
        
    }
    
    @objc
    private func textFieldSubmitted(_ sender: UITextField) {
        if let text = sender.text, let rowNumber = Int(text) {
            fetchLottoData(text) { [weak self] in
                self?.drawNumberPickerView.selectRow(rowNumber-1, inComponent: 0, animated: true)
            }
        } else {
            // enter int alert
            showAlert(.notIntError)
        }
    }
    
    private func fetchLottoData(_ drawNumber: String, completion: @escaping () -> () = {}) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="+drawNumber
        
        AF.request(url).response { [weak self] response in
            if let data = response.data, let decodedData = try? JSONDecoder().decode(LottoInfo.self, from: data) {
                switch decodedData.returnValue {
                case "success":
                    self?.configureData(decodedData)
                case "fail":
                    // show fail alert
                    print("this")
                    self?.showAlert(.unknown)
                    break
                default:
                    break
                }
                
                completion()
            }
        }
        
        
    }
    
    private func showAlert(_ type: FailAlertType) {
        let ac = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        let conform = UIAlertAction(title: "확인", style: .default)
        ac.addAction(conform)
        
        present(ac, animated: true)
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2000
    }
    
    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UILabel()
        view.text = "\(row+1) 회"
        view.textAlignment = .center
        return view
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetchLottoData(String(row+1)) { [weak self] in
            self?.textField.text = String(row+1)
        }
    }
}

struct LottoInfo: Decodable {
    let totSellamnt: Int
    let returnValue: String
    let drwNoDate: String
    let firstWinamnt: Int
    let firstPrzwnerCo: Int
    let firstAccumamnt: Int
    
    let drwNo: Int // 회차 번호
    
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}
