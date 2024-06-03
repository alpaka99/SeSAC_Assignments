//
//  ProfileViewController.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

class ProfileViewController: UIViewController {
    // background
    @IBOutlet var profileBackgroundView: UIImageView!
    
    // upper buttons
    @IBOutlet var xMarkButton: UIButton!
    @IBOutlet var firstUpperButton: UIButton!
    @IBOutlet var secondUpperButton: UIButton!
    @IBOutlet var thirdUpperButton: UIButton!
    
    private lazy var upperButtons: [UpperButtonType : UIButton] = [
        .xmark : xMarkButton,
        .first : firstUpperButton,
        .second : secondUpperButton,
        .third : thirdUpperButton
    ]
    
    // profile infos
    @IBOutlet var profilePictureImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileMessageLabel: UILabel!
    
    // lower buttons
    @IBOutlet var leftLowerButton: UIButton!
    @IBOutlet var centerLowerButton: UIButton!
    @IBOutlet var rightLowerButton: UIButton!
    
    private lazy var lowerButtons: [LowerButtonType : UIButton] = [
        .left : leftLowerButton,
        .center : centerLowerButton,
        .right : rightLowerButton
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set background
        setBackground()
        
        // set upper buttons
        setUpperButtons()
        
        // set profile infos
        setProfileInfos()
        
        // set lower buttons
        setLowerButtons()
    }
    
    private func setBackground() {
        profileBackgroundView.image = UIImage(named: "profileBackground")?.withRenderingMode(.alwaysOriginal)
        profileBackgroundView.contentMode = .scaleAspectFill
    }
    
    private func setUpperButtons() {
        upperButtons.keys.forEach { key in
            if let button = upperButtons[key] {
                var config = UIButton.Configuration.plain()
                config.title = ""
                
                config.image = UIImage(systemName: key.rawValue)
                
                button.configuration = config
                button.tintColor = .gray
                
                if key != .xmark {
                    button.layer.cornerRadius = button.frame.width / 2
                    button.layer.borderColor = UIColor.gray.cgColor
                    button.layer.borderWidth = 1
                }
            }
        }
    }
    
    private func setProfileInfos() {
        setProfilePictureView()
        setProfileNameView()
        setProfileMessageView()
    }
    
    private func setProfilePictureView() {
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.width / 4
        profilePictureImageView.layer.borderColor = UIColor.gray.cgColor
        profilePictureImageView.layer.borderWidth = 1
        
        profilePictureImageView.image = UIImage(systemName: "person.fill")
        profilePictureImageView.tintColor = .white
        profilePictureImageView.backgroundColor = .systemBlue
    }
    
    private func setProfileNameView() {
        profileNameLabel.textAlignment = .center
        profileNameLabel.text = "프로필 이름"
        profileNameLabel.font = .systemFont(
            ofSize: 20,
            weight: .semibold
        )
        profileNameLabel.textColor = .white
    }
    
    private func setProfileMessageView() {
        profileMessageLabel.textAlignment = .center
        profileMessageLabel.text = "프로필 메세지"
        profileMessageLabel.font = .systemFont(
            ofSize: 12,
            weight: .regular
        )
        profileMessageLabel.textColor = .white
    }
    
    private func setLowerButtons() {
        lowerButtons.keys.forEach { key in
            if let button = lowerButtons[key] {
                
                var config = UIButton.Configuration.plain()
//                config.title = key.rawValue
                var attributeContainer = AttributeContainer()
                attributeContainer.font = UIFont.systemFont(
                    ofSize: 10,
                    weight: .semibold
                )
                config.attributedTitle = AttributedString(key.rawValue, attributes: attributeContainer)
                config.image = UIImage(systemName: key.getImageName())
                config.imagePlacement = .top
                config.imagePadding = 4
                config.background.backgroundColor = .clear
                
                button.configuration = config
                
                button.configuration = config
                button.tintColor = .white
            }
        }
    }
}

private enum UpperButtonType: String, CaseIterable {
    case xmark = "xmark"
    case first = "lasso"
    case second = "paperplane.fill"
    case third = "trash"
}

private enum LowerButtonType: String, CaseIterable {
    case left = "나와의 채팅"
    case center = "프로필 수정"
    case right = "카카오 스토리"
    
    fileprivate func getImageName() -> String {
        switch self {
        case .left:
            return "message.fill"
        case .center:
            return "pencil"
        case .right:
            return "quote.closing"
        }
    }
}
