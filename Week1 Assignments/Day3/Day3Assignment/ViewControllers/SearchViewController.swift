//
//  SearchViewController.swift
//  Day3Assignment
//
//  Created by user on 5/16/24.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet var searchBarImageView: UIImageView!
    @IBOutlet var searchBarTextField: UITextField!
    @IBOutlet var searchBarBackgroundView: UIView!
    
    @IBOutlet var commingSoonButton: UIButton!
    @IBOutlet var popularContentButton: UIButton!
    @IBOutlet var topTenButton: UIButton!
    
    lazy var buttons: [UIButton] = [
        commingSoonButton,
        popularContentButton,
        topTenButton
    ]
    
    
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // tabBarItem
        setTabBarItem()
        
        // navigationItem
        setNavigationItem()
        
        // searchBar
        setSearchBarLayouts()
        
        // buttons
        setButtonLayouts()
        
        // labels
        setLabels()
    }
    
    private func setTabBarItem() {
        navigationController?.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle.fill")
        navigationController?.tabBarItem.title = "NEW & HOT"
    }
    
    private func setNavigationItem() {
        navigationItem.title = "NEW & HOT 검색"
    }
    
    private func setSearchBarLayouts() {
        searchBarImageView.image = UIImage(systemName: "magnifyingglass")
        searchBarImageView.tintColor = .white
        searchBarImageView.backgroundColor = .clear
        
        searchBarTextField.borderStyle = .none
        searchBarTextField.placeholder = searchBarPlaceholder
        searchBarTextField.backgroundColor = .clear
        searchBarTextField.textColor = .white
        
        searchBarBackgroundView.backgroundColor = .gray
        searchBarBackgroundView.layer.cornerRadius = 8
    }
    
    
    
    private func setButtonLayouts() {
        setCommingSoonButtonLayout()
        setPopularButtonLayout()
        setTopTenButtonLayout()
        setCommonButtonLayouts()
    }
    
    private func setCommonButtonLayouts() {
        buttons.forEach { button in
            button.layer.cornerRadius = 12
            button.imageEdgeInsets.right = 20
        }
    }
    
    private func setCommingSoonButtonLayout() {
        commingSoonButton.setImage(
            UIImage(named: ButtonInfo.commingSoon.getColor()),
            for: .normal
        )
        
        setAttributedString(commingSoonButton, .commingSoon, .initiated)
        commingSoonButton.backgroundColor = .white
    }
    
    private func setPopularButtonLayout() {
        popularContentButton.setImage(
            UIImage(named: ButtonInfo.popularContent.getColor()),
            for: .normal
        )
        
        setAttributedString(popularContentButton, .popularContent, .initiated)
    }
    
    private func setTopTenButtonLayout() {
        topTenButton.setImage(
            UIImage(named: ButtonInfo.topTen.getColor()),
            for: .normal
        )
        
        setAttributedString(topTenButton, .topTen, .initiated)
    }
    
    private func setAttributedString(
        _ button: UIButton,
        _ buttonType: ButtonInfo,
        _ buttonState: ButtonStates
    ) {
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 8),
            NSAttributedString.Key.foregroundColor : setAttributedStringColor(
                buttonType,
                buttonState
            )
        ]
        let attributeTitle = NSAttributedString(
            string: buttonType.getTitle(),
            attributes: attributes
        )
        button.setAttributedTitle(
            attributeTitle,
            for: .normal
        )
    }
    
    private func setAttributedStringColor(
        _ buttonType: ButtonInfo,
        _ buttonState: ButtonStates
    ) -> UIColor {
        var colorAttribute: UIColor = UIColor.clear
        
        switch buttonState {
        case .initiated:
            switch buttonType {
            case .commingSoon:
                colorAttribute = UIColor.black
            default:
                colorAttribute = UIColor.white
            }
        case .pressed:
            colorAttribute = UIColor.black
        case .released:
            colorAttribute = UIColor.white
        }
        return colorAttribute
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if
            let buttonTitle = sender.titleLabel?.text,
            let buttonType = ButtonInfo.titleInit(buttonTitle) {
            mainLabel.text = "\(buttonTitle)이 눌렸습니다"
            subLabel.isHidden = true
            subLabel.layer.opacity = 0
            
            changeButtonColor(buttonType)
        }
    }
    
    private func changeButtonColor(_ buttonType: ButtonInfo) {
        buttons.forEach { button in
            if let text = button.titleLabel?.text {
                if text == buttonType.getTitle() {
                    buttonPressed(button)
                } else {
                    buttonReleased(button)
                }
            }
        }
    }
    
    private func buttonReleased(_ button: UIButton) {
        if let title = button.titleLabel?.text {
            button.backgroundColor = .clear
            setAttributedString(
                button,
                ButtonInfo.titleInit(title) ?? .commingSoon,
                .released
            )
        }
    }
    
    private func buttonPressed(_ button: UIButton) {
        if let title = button.titleLabel?.text {
            button.backgroundColor = .white
            setAttributedString(
                button,
                ButtonInfo.titleInit(title) ?? .commingSoon,
                .pressed
            )
            button.tintColor = .black
            button.layer.borderWidth = 0
        }
    }
    
    private func setLabels() {
        setMainLabel()
        setSubLabel()
    }
    
    private func setMainLabel(_ text: String = defaultMainLabelText) {
        mainLabel.text = text
        mainLabel.font = UIFont.systemFont(
            ofSize: 24,
            weight: .heavy
        )
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
    }
    
    private func setSubLabel(_ text: String = defaultSubLabelText) {
        subLabel.text = text
        subLabel.font = UIFont.systemFont(
            ofSize: 12,
            weight: .semibold
        )
        subLabel.textAlignment = .center
        subLabel.textColor = .white
    }
    
    
    @IBAction func searchEnded(_ sender: UITextField) {
        if let searchText = sender.text {
            mainLabel.text = "\"\(searchText)\"가 검색되었습니다"
            subLabel.isHidden = false
            subLabel.layer.opacity = 1
        }
    }
}

fileprivate enum ButtonInfo: String {
    case commingSoon = "blue"
    case popularContent = "turquoise"
    case topTen = "pink"
    
    func getColor() -> String {
        switch self {
        case .commingSoon:
            return "blue"
        case .popularContent:
            return "turquoise"
        case .topTen:
            return "pink"
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .commingSoon:
            return "공개 예정"
        case .popularContent:
            return "모두의 인기 콘텐츠"
        case .topTen:
            return "TOP 10 시리즈"
        }
    }
    
    static func titleInit(_ text: String) -> Self? {
        switch text {
        case "공개 예정":
            return Self.commingSoon
        case "모두의 인기 콘텐츠":
            return Self.popularContent
        case "TOP 10 시리즈":
            return Self.topTen
        default:
            return nil
        }
    }
}

fileprivate let searchBarPlaceholder: String = "게임, 시리즈, 영화등을 검색해보세요..."
fileprivate let defaultMainLabelText: String = "이런! 찾으시는 작품이 없습니다"
fileprivate let defaultSubLabelText: String = "다른 영화, 시리즈, 배우 감독등을 검색해보세요"


fileprivate enum ButtonStates {
    case initiated
    case pressed
    case released
}
