//
//  EmotionDiaryViewController.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
//

import UIKit

final class EmotionDiaryViewController:
    UIViewController {
    @IBOutlet var slimeBackgroundImageView: UIImageView!
    
    @IBOutlet var smileButton: UIButton!
    @IBOutlet var happyButton: UIButton!
    @IBOutlet var loveButton: UIButton!
    @IBOutlet var angryButton: UIButton!
    @IBOutlet var sosoButton: UIButton!
    @IBOutlet var sleepyButton: UIButton!
    @IBOutlet var embarrasedButton: UIButton!
    @IBOutlet var unHappyButton: UIButton!
    @IBOutlet var cryButton: UIButton!
    
    private lazy var emotionButtons: [EmotionType : UIButton] = [
        .smile : smileButton,
        .happy : happyButton,
        .love : loveButton,
        .angry : angryButton,
        .soso : sosoButton,
        .sleepy : sleepyButton,
        .embarrased : embarrasedButton,
        .unHappy : unHappyButton,
        .cry : cryButton
    ]
    
    private var buttonCountDictionary: [EmotionType : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set Data
        setButtonCountDictionary()
        
        // setTab Bar
        setTabBar()
        
        // set Navigation Bar
        setNavigationBar()
        
        // background Image
        setBackgroundImageView()
        
        // buttons
        setButtons()
    }
    
    
    private func setButtonCountDictionary() {
        EmotionType.allCases.forEach { emotionType in
            buttonCountDictionary[emotionType] = 0
        }
    }
    
    private func setTabBar() {
        navigationController?.tabBarItem.title = EmotionDiaryConstants.tabItemTitle
        navigationController?.tabBarItem.image = UIImage(systemName: EmotionDiaryConstants.tabBarItemImageName)
    }
    
    private func setNavigationBar() {
        // navigation bar title
        navigationItem.title = EmotionDiaryConstants.navigationTitle
    
        // navigation bar left button
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: EmotionDiaryConstants.leftBarButtonImageName),
            style: .plain,
            target: self,
            action: #selector(showDetailController)
        )
        leftBarButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func showDetailController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DetailConstants.identifier) as? DetailViewController {
            vc.title = DetailConstants.title
            vc.buttonCountDictionary = buttonCountDictionary
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setBackgroundImageView() {
        slimeBackgroundImageView.image = UIImage(named: EmotionDiaryConstants.backgroundImageName)
        slimeBackgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func setButtons() {
        var tagNumber = 0
        EmotionType.allCases.forEach { emotionType in
            if let button = emotionButtons[emotionType] {
                if let count = buttonCountDictionary[emotionType] {
                    let title = "\(emotionType.rawValue) \(count)"
                    setButtonConfig(
                        for: button,
                        with: title,
                        emotionType: emotionType
                    )
                    
                    button.tag = tagNumber
                    tagNumber += 1
                }
            }
        }
    }
    
    private func setButtonConfig(
        for button: UIButton,
        with title: String,
        emotionType: EmotionType
    ) {
        // plain button configuration
        var config = UIButton.Configuration.plain()
        
        // button image configurations
        config.image?.withRenderingMode(.alwaysOriginal)
        config.image = UIImage(named: emotionType.imageName())?.resizeImage(withSize: CGSize(
            width: 65,
            height: 60
        ))
        config.imagePlacement = .top
        config.imagePadding = 4
        
        // button title configurations
        var titleAttributes = AttributeContainer()
        titleAttributes.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        config.attributedTitle = AttributedString(
            title,
            attributes: titleAttributes
        )
        button.tintColor = .black
        
        config.background.backgroundColor = .white.withAlphaComponent(0.3)
        config.cornerStyle = .capsule
        
        // apply configuration
        button.configuration = config
        button.configurationUpdateHandler = { btn in
            // some action associated with button state
            switch btn.state {
            case .highlighted:
                UIView.animate(withDuration: 0.1, delay: 0) {
                    btn.transform = CGAffineTransform(
                        scaleX: 1.5,
                        y: 1.5
                    )
                }
            case .normal:
                UIView.animate(withDuration: 0.1, delay: 0) {
                    btn.transform = CGAffineTransform.identity
                }
            default:
                break
            }
        }
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        if let emotionType = EmotionType.createEmotionTypeByTagNumber(sender.tag) {
            if let emotionCount = buttonCountDictionary[emotionType] {
                let newCount = emotionCount + 1
                buttonCountDictionary[emotionType] = newCount
                changeButtonCount(
                    emotionType,
                    with: newCount
                )
            }
        }
    }
    
    private func changeButtonCount(
        _ emotionType: EmotionType,
        with count: Int
    ) {
        let newTitle = "\(emotionType.rawValue) \(String(count))"
        
        if let button = emotionButtons[emotionType] {
            setButtonConfig(
                for: button,
                with: newTitle,
                emotionType: emotionType
            )
        }
    }
}


internal enum EmotionType: String, CaseIterable {
    case smile = "재밌어"
    case happy = "행복해"
    case love = "사랑해"
    case angry = "화나"
    case soso = "그저그래"
    case sleepy = "잠온다"
    case embarrased = "당황해"
    case unHappy = "안행복해"
    case cry = "눈물나"

    
    
    internal func imageName() -> String {
        switch self {
        case .smile:
            return EmotionDiaryConstants.smileButtonImageName
        case .happy:
            return EmotionDiaryConstants.happyButtonImageName
        case .love:
            return EmotionDiaryConstants.loveButtonImageName
        case .angry:
            return EmotionDiaryConstants.angryButtonImageName
        case .soso:
            return EmotionDiaryConstants.sosoButtonImageName
        case .sleepy:
            return EmotionDiaryConstants.sleepyButtonImageName
        case .embarrased:
            return EmotionDiaryConstants.embarrasedButtonImageName
        case .unHappy:
            return EmotionDiaryConstants.unHappyButtonImageName
        case .cry:
            return EmotionDiaryConstants.cryButtonImageName
        }
    }
    
//    internal func titleName() -> String {
//        switch self {
//        case .smile:
//            return "재밌어"
//        case .happy:
//            return "행복해"
//        case .love:
//            return "사랑해"
//        case .angry:
//            return "화나"
//        case .soso:
//            return "그저그래"
//        case .sleepy:
//            return "잠온다"
//        case .embarrased:
//            return "당황해"
//        case .unHappy:
//            return "안행복해"
//        case .cry:
//            return "눈물나"
//        }
//    }
    
    static func createEmotionTypeByTagNumber(_ tagNumber: Int) -> Self? {
        switch tagNumber {
        case 0: // smile buttton action
            return .smile
        case 1: // happy buttton action
            return .happy
        case 2: // love buttton action
            return .love
        case 3: // angry buttton action
            return .angry
        case 4: // soso buttton action
            return .soso
        case 5: // sleepy buttton action
            return .sleepy
        case 6: // unHappy buttton action
            return .embarrased
        case 7: // embarrased buttton action
            return .unHappy
        case 8: // cry button action
            return .cry
        default:
            return nil
        }
    }
}



