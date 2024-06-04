//
//  HomeViewController.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let mainPoster: UIImageView = ImageViewType.poster(ImageViewConstants.mainPosterImageName).build()
    
    let categoryLabel: UILabel = LabelType.information(LabelConstants.homeCategoryLabel).build()
    let playButton: UIButton = ButtonType.common(ButtonConstants.playButtonImageName, ButtonConstants.playButtonTitle).build()
    let savedButton: UIButton = ButtonType.transparentButton(ButtonConstants.savedButtonImageName, ButtonConstants.savedButtonTitle ).build()
    lazy var buttonStack: UIStackView = UIStackView(arrangedSubviews: [playButton, savedButton])
    
    let bottomBackground: UIView = BackgroundType.colored.build()
    let bottomLabel: UILabel = LabelType.title(LabelConstants.homeCategoryLabel).build()
    let firstPoster: UIImageView = ImageViewType.poster(ImageViewConstants.firstPosterImageName).build()
    let secondPoster: UIImageView = ImageViewType.poster(ImageViewConstants.secondPosterImageName).build()
    let thirdPoster: UIImageView = ImageViewType.poster(ImageViewConstants.thirdPosterImageName).build()
    lazy var bottomPosterStack: UIStackView = UIStackView(arrangedSubviews: [
        firstPoster,
        secondPoster,
        thirdPoster
    ])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        
        configureLayout()
        
        configureUI()
    }
    
    private func configureHierarchy() {
        view.addSubview(mainPoster)
        mainPoster.addSubview(buttonStack) // 잭님이 수업시간에 imageview에 뭐 넣지 말라고 하셨는데 이럴땐 어떡하지...
        mainPoster.addSubview(categoryLabel)
        
        view.addSubview(bottomBackground)
        bottomBackground.addSubview(bottomLabel)
        bottomBackground.addSubview(bottomPosterStack)
    }
    
    private func configureLayout() {
        configureMainPosterLayout()
        configureButtonStackLayout()
        configureCategoryLabel()
        configureBackground()
        configureBottomLabel()
        configureBottomPosterStack()
    }
    
    func configureMainPosterLayout() {
        mainPoster.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width)
                .multipliedBy(0.85)
            
            make.height.equalTo(mainPoster.snp.width)
                .multipliedBy(1.4)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureButtonStackLayout() {
        buttonStack.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(mainPoster)
                .inset(8)
        }
    }
    
    func configureCategoryLabel() {
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(buttonStack.snp.top)
                .offset(-12)
            make.centerX.equalTo(buttonStack.snp.centerX)
        }
    }
    
    func configureBackground() {
        bottomBackground.snp.makeConstraints { make in
            make.top.equalTo(mainPoster.snp.bottom)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureBottomLabel() {
        bottomLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(bottomBackground)
            make.height.equalTo(28) // MARK: 왜 height을 안잡아주면 textlabel이 사라질까..? -> layout을 잡는 시점에는 아무것도 안들어있어서 높이가 0이 되는건가?
        }
    }
    
    func configureBottomPosterStack() {
        
        
        bottomPosterStack.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom)
                .offset(8)
            make.horizontalEdges.equalTo(bottomBackground.snp.horizontalEdges)
                .inset(8)
            make.bottom.equalTo(bottomBackground)
                .inset(8)
        }
    }
    
    private func configureUI() {
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 8
        
        bottomPosterStack.axis = .horizontal
        bottomPosterStack.spacing = 8
        bottomPosterStack.distribution = .fillEqually
    }
}
