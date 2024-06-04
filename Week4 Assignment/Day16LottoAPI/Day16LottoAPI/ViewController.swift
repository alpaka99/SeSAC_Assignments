//
//  ViewController.swift
//  Day16LottoAPI
//
//  Created by user on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

//https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=861
class ViewController: UIViewController {

    let webUrl: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
    
    let textField: UITextField = UITextField()
    
    var ballStack: UIStackView = UIStackView()
    lazy var firstBall: UILabel = createLottoBall(0)
    lazy var secondBall: UILabel = createLottoBall(0)
    lazy var thirdBall: UILabel = createLottoBall(0)
    lazy var fourthBall: UILabel = createLottoBall(0)
    lazy var fifthBall: UILabel = createLottoBall(0)
    lazy var sixthBall: UILabel = createLottoBall(0)
    lazy var plus: UIView = createPlus()
    lazy var bonusBall: UILabel = createLottoBall(0)
    lazy var stackContents: [UIView] = [
        firstBall,
        secondBall,
        thirdBall,
        fourthBall,
        fifthBall,
        sixthBall,
        plus,
        bonusBall
    ]
    lazy var stackView: UIStackView = UIStackView(arrangedSubviews: stackContents)
    let searchButton: UIButton = UIButton()
    let lottoDescription: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        
        layoutViews()
        
        configureUI()
    }
    
    
    func fetchLottoData(_ text: String?) {
        print(#function)
        if let number = text, let _ = Int(number) {
            AF.request(webUrl+number).response { [weak self] response in
                switch response.result {
                case .success(_):
                    self?.convertData(response.data)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.showAlert()
                }
            }
        } else {
            showAlert()
        }
    }

    func convertData(_ data: Data?) {
        if let data = data {
            if let decodedData = try? JSONDecoder().decode(LottoInfo.self, from: data) {
                print(decodedData)
                setLottoBallNumbers(decodedData)
                setLottoDescription(decodedData)
            }
        }
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(lottoDescription)
    }
    
    func layoutViews() {
        layoutTextField()
        layoutSearchButton()
        layoutStackView()
        layoutLottoDescription()
    }
    
    func layoutTextField() {
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
                .multipliedBy(0.7)
                .offset(16)
            make.width.equalTo(300)
        }
    }
    
    func layoutSearchButton() {
        searchButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(textField.snp.verticalEdges)
            make.leading.equalTo(textField.snp.trailing)
                .offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
                .offset(-8)
        }
    }
    
    func layoutStackView() {
        stackView = UIStackView.init(arrangedSubviews: stackContents)
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
                .offset(80)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
        }
    }
    
    func layoutLottoDescription() {
        lottoDescription.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
                .offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
    }
    
    func createLottoBall(_ number: Int) -> UILabel {
        let lottoBall = UILabel()
        
        lottoBall.backgroundColor = UIColor.randomColor
        lottoBall.text = String(number)
        lottoBall.textAlignment = .center
        lottoBall.textColor = .white
        lottoBall.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        
        lottoBall.clipsToBounds = true
        
        lottoBall.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        lottoBall.layer.cornerRadius = 22

        return lottoBall
    }
    
    func createPlus() -> UIImageView {
        return UIImageView(image: UIImage(systemName: "plus"))
    }
    
    func configureUI() {
        configureTextField()
        configureSearchButton()
        configureStackView()
        configureLottoDescription()
    }
    
    func configureTextField() {
        textField.placeholder = "로또 회차를 검색해보세요"
        textField.textAlignment = .center
        
        textField.addTarget(self, action: #selector(textFieldSubmitted), for: .editingDidEndOnExit)
    }
    
    func configureSearchButton() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
    }
    
    func configureLottoDescription() {
        lottoDescription.font = .systemFont(ofSize: 20, weight: .bold)
        lottoDescription.numberOfLines = 0
    }
    
    func setLottoBallNumbers(_ data: LottoInfo) {
        firstBall.text = String(data.drwtNo1)
        secondBall.text = String(data.drwtNo2)
        thirdBall.text = String(data.drwtNo3)
        fourthBall.text = String(data.drwtNo4)
        fifthBall.text = String(data.drwtNo5)
        sixthBall.text = String(data.drwtNo6)
        bonusBall.text = String(data.bnusNo)
    }
    
    func setLottoDescription(_ data: LottoInfo) {
        lottoDescription.text = data.lottoDescription
    }
    
    @objc
    func textFieldSubmitted(_ sender: UITextField) {
        fetchLottoData(sender.text)
    }
    
    @objc
    func searchButtonTapped(_ sender: UIButton) {
        fetchLottoData(textField.text)
    }
    
    func showAlert() {
        let ac = UIAlertController(title: "검색 실패", message: "해당 회차는 로또 기록이 없습니다 :(", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}


struct LottoInfo: Codable {
    let totSellamnt: Int
    let returnValue: String
    let drwNoDate: String
    let firstWinamnt: Int
    let firstPrzwnerCo: Int
    let firstAccumamnt: Int
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
    var lottoDescription: String {
        return "1등 당첨금 \(firstWinamnt.formatted())원 (당첨 복권수 \(firstPrzwnerCo))"
    }
}


extension UIColor {
    static var randomColor: UIColor {
        return UIColor.init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
}

