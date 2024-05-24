//
//  SavedContentViewController.swift
//  Day3Assignment
//
//  Created by user on 5/16/24.
//

import UIKit

final class SavedContentViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    @IBOutlet var cardPosterImageView: UIImageView!
    
    @IBOutlet var configureButton: UIButton!
    @IBOutlet var lookSavableContentButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewBackground
        self.view.backgroundColor = .black
        
        // tabBarItem
        setTabBarItem()
        
        // navigationItem
        setNavigationItem()
        
        // labels
        setLabels()
        
        // imageView
        setCardPosterImageView()
        
        // buttons
        setButtons()
    }
    
    private func setTabBarItem() {
        navigationController?.tabBarItem.title = "저장한 콘텐츠 목록"
        navigationController?.tabBarItem.image = UIImage(systemName: "arrow.down.circle.fill")
    }
    
    private func setNavigationItem() {
        navigationItem.title = "저장한 콘텐츠 목록"
    }
    
    private func setLabels() {
        setMainLabel()
        setSubLabel()
    }
    
    private func setMainLabel() {
        mainLabel.text = "\"나만의 자동 저장\"기능"
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(
            ofSize: 24,
            weight: .heavy
        )
        mainLabel.textColor = .lightGray
    }
    
    private func setSubLabel() {
        subLabel.text = "취향에 맞는 서비스를 자동으로 저장해 드립니다.\n 디바이스에 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요."
        subLabel.numberOfLines = 0
        subLabel.textAlignment = .center
        subLabel.font = .systemFont(
            ofSize: 12,
            weight: .bold
        )
        subLabel.textColor = .lightGray
    }
    
    private func setCardPosterImageView() {
        cardPosterImageView.image = UIImage(named: "dummy")
        cardPosterImageView.contentMode = .scaleAspectFill
    }
    
    private func setButtons() {
        setConfigureButton()
        setLookSavableContentButton()
    }
    
    private func setConfigureButton() {
        configureButton.setTitle(
            "설정하기",
            for: .normal
        )
        
        configureButton.setTitleColor(
            .white,
            for: .normal
        )
        
        configureButton.backgroundColor = .systemIndigo
        configureButton.layer.cornerRadius = 8
    }
    
    private func setLookSavableContentButton() {
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(
            ofSize: 12,
            weight: .heavy
        ),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        let attributedString = NSAttributedString(
            string: "저장 가능한 콘텐츠 살펴보기",
            attributes: attributes
        )
        lookSavableContentButton.setAttributedTitle(
            attributedString,
            for: .normal
        )
        lookSavableContentButton.backgroundColor = .white
        lookSavableContentButton.layer.cornerRadius = 8
    }
}
