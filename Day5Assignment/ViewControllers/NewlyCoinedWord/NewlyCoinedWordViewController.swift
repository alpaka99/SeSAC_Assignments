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
    
    private lazy var randomButtons: [UIButton] = [
        firstMZLanguageButton,
        secondMZLanguageButton,
        thirdMZLanguageButton,
        fourthMZLanguageButton
    ]
    
    // new computed property
    private var numberOfRandomButtons: Int {
        return randomButtons.count
    }
    
    @IBOutlet var mzResultImageView: UIImageView!
    @IBOutlet var mzResultLabel: UILabel!
    
    
    // new computed properties
    private var randomWordArray: [MZWordType]  {
        return MZWordType.allCases.shuffled()
    }
    
    private var selectedRandomWords: [MZWordType] {
        return Array(randomWordArray[0..<numberOfRandomButtons])
    }
    
    private var randomViewContollerType: RandomViewControllerType? {
        return RandomViewControllerType.allCases.randomElement()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setTabBar
        setTabBar()
        
        // set navigationBar
        setNavigationBar()
        
        // setTextField
        setTextFieldArea()
        
        // set mzLanguage buttons
        setMZLanguageButtons()
        
        // setResultArea
        setResultArea()
    }
    
    // MARK: 이 부분은 view가 켜져야 보이는 부분이기 때문에 해당 탭을 눌러서 view를 초기화 하지 않으면 안보임. 그러면 어떻게 처음부터 보이게 할 수 있을까? 방법은 UITabBarController를 상속받는 클래스를 만들어서 거기에서 초기화부터 다 해주면 됨
    private func setTabBar() {
        navigationController?.tabBarItem.title = NewlyCoinedWordConstants.tabBarTitle
        navigationController?.tabBarItem.image = UIImage(systemName: NewlyCoinedWordConstants.tabBarItemImageName)
    }
    
    private func setNavigationBar() {
        navigationItem.title = NewlyCoinedWordConstants.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: NewlyCoinedWordConstants.rightBarButtonImageName),
            style: .plain,
            target: self,
            action: #selector(showRandomViewController)
        )
    }
    
    @objc private func showRandomViewController() {
        if let randomViewContollerType = randomViewContollerType {
            switch randomViewContollerType {
            case .profile:
                if let vc = storyboard?.instantiateViewController(identifier: randomViewContollerType.rawValue) as? ProfileViewController {
                    present(vc, animated: true)
                }
            case .musicPlayer:
                if let vc = storyboard?.instantiateViewController(identifier: randomViewContollerType.rawValue) as? MusicPlayerViewController {
                    present(vc, animated: true)
                }
            case .baemin:
                if let vc = storyboard?.instantiateViewController(identifier: randomViewContollerType.rawValue) as? BaeminViewController {
                    present(vc, animated: true)
                }
            }
        }
    }
    
    private func setTextFieldArea() {
        setMZTextField()
        setMZSearchButton()
        setMZTextFieldBackground()
    }
    
    private func setMZTextField() {
        mzTextField.borderStyle = .none
        mzTextField.placeholder = NewlyCoinedWordConstants.placeholder
        mzTextField.clearButtonMode = .whileEditing
    }
    
    private func setMZSearchButton() {
        mzSearchButton.setImage(UIImage(systemName: NewlyCoinedWordConstants.searchButtonImageName), for: .normal)
        mzSearchButton.setTitle("", for: .normal)
        mzSearchButton.backgroundColor = .black
        mzSearchButton.tintColor = .white
    }
    
    private func setMZTextFieldBackground() {
        mzTextFieldBackgroundView.layer.borderColor = UIColor.black.cgColor
        mzTextField.layer.borderWidth = 2
    }
    
    private func setMZLanguageButtons() {
        let randomMZWords: [MZWordType] = selectedRandomWords
        
        for i in 0..<numberOfRandomButtons {
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
            mzWord.rawValue,
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
        mzResultImageView.image = UIImage(named: NewlyCoinedWordConstants.imageViewBackgroundImageName)
        mzResultImageView.contentMode = .scaleAspectFill
    }
    
    private func setMZResultLabel() {
        mzResultLabel.numberOfLines = 0
        changeMZResultLableText(NewlyCoinedWordConstants.initialLabelText)
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
    
    
//    fileprivate func getKey() -> String {
//        switch self {
//        case .디토:
//            return "디토"
//        case .kijul:
//            return "KIJUL"
//        case .중꺾그마:
//            return "중꺾그마"
//        case .ㄱㅂㅈㄱ:
//            return "ㄱㅂㅈㄱ"
//        case .그잡채:
//            return "그 잡채"
//        case .h워얼v:
//            return "H워얼V"
//        case .내또출:
//            return "내또출"
//        case .일며들다:
//            return "일며들다"
//        case .당모치:
//            return "당모치"
//        case .잼얘:
//            return"잼얘"
//        case .군싹:
//            return "군싹"
//        case .sbn:
//            return "SBN"
//        }
//    }
    
    fileprivate func getValue() -> String {
        switch self {
        case .디토:
            return NewlyCoinedWordConstants.디토Value
        case .kijul:
            return NewlyCoinedWordConstants.kijulValue
        case .중꺾그마:
            return NewlyCoinedWordConstants.중꺾그마Value
        case .ㄱㅂㅈㄱ:
            return NewlyCoinedWordConstants.ㄱㅂㅈㄱValue
        case .그잡채:
            return NewlyCoinedWordConstants.그잡채Value
        case .h워얼v:
            return NewlyCoinedWordConstants.h워얼vValue
        case .내또출:
            return NewlyCoinedWordConstants.내또출Value
        case .일며들다:
            return NewlyCoinedWordConstants.일며들다Value
        case .당모치:
            return NewlyCoinedWordConstants.당모치Value
        case .잼얘:
            return NewlyCoinedWordConstants.잼얘Value
        case .군싹:
            return NewlyCoinedWordConstants.군싹Value
        case .sbn:
            return NewlyCoinedWordConstants.sbnValue
        }
    }
    
//    static func getRandomMZWords(of limit: Int) -> [Self] {
//        let mzWords: [Self] = Self.allCases
//        let mzWordCount = mzWords.count
//        
//        var randomMZWords: Set<Self> = []
//        
//        while randomMZWords.count < limit {
//            randomMZWords.insert(mzWords[Int.random(in: 0..<mzWordCount)])
//        }
//        
//        return Array(randomMZWords)
//    }
}


private enum RandomViewControllerType: String, CaseIterable {
    case profile = "ProfileViewController"
    case musicPlayer = "MusicPlayerViewController"
    case baemin = "BaeminViewController"
    
}
