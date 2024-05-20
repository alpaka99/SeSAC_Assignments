//
//  NewlyCoinedWordViewController.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

final class NewlyCoinedWordViewController: UIViewController {
    @IBOutlet var mzTextField: UITextField!
    @IBOutlet var mzSearchButton: UIButton!
    @IBOutlet var mzTextFieldBackgroundView: UIView!
    
    @IBOutlet var firstMZLanguageButton: UIButton!
    @IBOutlet var secondMZLanguageButton: UIButton!
    @IBOutlet var thirdMZLanguageButton: UIButton!
    @IBOutlet var fourthMZLanguageButton: UIButton!
    
    lazy var randomButtons: [UIButton] = [
        firstMZLanguageButton,
        secondMZLanguageButton,
        thirdMZLanguageButton,
        fourthMZLanguageButton
    ]
    
    @IBOutlet var mzResultImageView: UIImageView!
    @IBOutlet var mzResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        // setTabBar
        setTabBar()
        
        // setTextField
        setTextFieldArea()
        
        // set mzLanguage buttons
        setMZLanguageButtons()
        
        // setResultArea
        setResultArea()
    }
    
    // MARK: 이 부분은 view가 켜져야 보이는 부분이기 때문에 해당 탭을 눌러서 view를 초기화 하지 않으면 안보임. 그러면 어떻게 처음부터 보이게 할 수 있을까? 방법은 UITabBarController를 상속받는 클래스를 만들어서 거기에서 초기화부터 다 해주면 됨
    private func setTabBar() {
        navigationController?.tabBarItem.title = "MZ Language"
        navigationController?.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
    }
    
    private func setTextFieldArea() {
        setMZTextField()
        setMZSearchButton()
        setMZTextFieldBackground()
    }
    
    private func setMZTextField() {
        mzTextField.borderStyle = .none
        mzTextField.placeholder = "어떤 신조어가 궁금하신가요..?"
        mzTextField.clearButtonMode = .whileEditing
    }
    
    private func setMZSearchButton() {
        mzSearchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        mzSearchButton.setTitle("", for: .normal)
        mzSearchButton.backgroundColor = .black
        mzSearchButton.tintColor = .white
    }
    
    private func setMZTextFieldBackground() {
        mzTextFieldBackgroundView.layer.borderColor = UIColor.black.cgColor
        mzTextField.layer.borderWidth = 2
    }
    
    private func setMZLanguageButtons() {
        let randomMZWords: [MZWordType] = MZWordType.getRandomMZWords(of: randomButtons.count)
        
        for i in 0..<randomButtons.count {
            let randomButton = randomButtons[i]
            setRandomButton(
                randomButton,
                withIndex: i,
                mzWord: randomMZWords[i]
            )
        }
    }
    
    //MARK: UIButton.Configuration을 사용할때 Configuration 이외의 방법으로 설정을 할 경우 이상한 현상들 발생(e.g 버튼 폰트 지정)
    private func setRandomButton(
        _ button: UIButton,
        withIndex index: Int,
        mzWord: MZWordType
    ) {
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        config.attributedTitle = AttributedString(
            mzWord.getKey(),
            attributes: titleContainer
        )
        
        button.configuration = config
        
        button.tag = index
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.tintColor = .black
        button.titleLabel?.numberOfLines = 1
        button.sizeToFit()
    }
    
    private func setButtonTitleFont(_ button: UIButton) {
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 8,
            weight: .heavy
        )
    }
    
    private func setResultArea() {
        setMZImageView()
        setMZResultLabel()
    }
    
    private func setMZImageView() {
        mzResultImageView.image = UIImage(named: "background")
        mzResultImageView.contentMode = .scaleAspectFill
    }
    
    private func setMZResultLabel() {
        mzResultLabel.numberOfLines = 0
        changeMZResultLableText("신조어를 검색해보세요!")
    }
    
    private func changeMZResultLableText(_ text: String) {
        mzResultLabel.text = text
        mzResultLabel.textAlignment = .center
    }
    
    @IBAction func submitTextField(_ sender: UITextField) {
        if let text = sender.text, text.isEmpty == false {
            searchMZLanguage(text)
        }
        slideDownKeyboard()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if let text = mzTextField.text,
           text.isEmpty == false {
            searchMZLanguage(text)
        }
        slideDownKeyboard()
    }
    
    private func searchMZLanguage(_ text: String) {
        showMZLanguageResult(text)
        setMZLanguageButtons()
    }
    
    private func showMZLanguageResult(_ text: String) {
        if let resultText = MZWordType.init(rawValue: text) {
            mzResultLabel.text = "\"\(text)\"는 \"\(resultText.getValue())\"라는 뜻입니다"
        } else {
            mzResultLabel.text = "\"\(text)\"는 신조어 사진에 등록되지 않았습니다 :("
        }
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        if let searchText = sender.titleLabel?.text {
            mzTextField.text = searchText
        }
    }
    
    
    private func slideDownKeyboard() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        slideDownKeyboard()
    }
    
}


private enum MZWordType: String, CaseIterable {
    case 디토 = "디토"
    case kijul = "KIJUL"
    case 중꺾그마 = "중꺾그마"
    case ㄱㅂㅈㄱ = "ㄱㅂㅈㄱ"
    case 그잡채 = "그 잡채"
    case h워얼v = "H워얼V"
    case 내또출 = "내또출"
    case 일며들다 = "일며들다"
    case 당모치 = "당모치"
    case 잼얘 = "잼얘"
    case 군싹 = "군싹"
    case sbn = "SBN"
    
    
    fileprivate func getKey() -> String {
        switch self {
        case .디토:
            return "디토"
        case .kijul:
            return "KIJUL"
        case .중꺾그마:
            return "중꺾그마"
        case .ㄱㅂㅈㄱ:
            return "ㄱㅂㅈㄱ"
        case .그잡채:
            return "그 잡채"
        case .h워얼v:
            return "H워얼V"
        case .내또출:
            return "내또출"
        case .일며들다:
            return "일며들다"
        case .당모치:
            return "당모치"
        case .잼얘:
            return"잼얘"
        case .군싹:
            return "군싹"
        case .sbn:
            return "SBN"
        }
    }
    
    fileprivate func getValue() -> String {
        switch self {
        case .디토:
            return "동의합니다"
        case .kijul:
            return "너무 재밌어서 기절하겠다"
        case .중꺾그마:
            return "중요한건 꺾였는데도 그냥 하는 마음"
        case .ㄱㅂㅈㄱ:
            return "가보자고"
        case .그잡채:
            return "그 자체"
        case .h워얼v:
            return "180도 회정시켜 보면 \'사랑해\'"
        case .내또출:
            return "내일 또 출근이야"
        case .일며들다:
            return "일이 내 삶에 스며들었다"
        case .당모치:
            return "당연히 모든 치킨은 옳다"
        case .잼얘:
            return "재밋는 이야기"
        case .군싹:
            return "군침이 싹 도네"
        case .sbn:
            return "선배님"
        }
    }
    
    static func getRandomMZWords(of limit: Int) -> [Self] {
        let mzWords: [Self] = Self.allCases
        let mzWordCount = mzWords.count
        
        var randomMZWords: Set<Self> = []
        
        while randomMZWords.count < limit {
            randomMZWords.insert(mzWords[Int.random(in: 0..<mzWordCount)])
        }
        
        return Array(randomMZWords)
    }
}

