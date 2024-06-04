//
//  HomeViewController.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let mainPoster: UIImageView = ImageViewType.poster("노량").build()
    
    let categoryLabel: UILabel = LabelType.information("응원하고픈 • 흥미진진 • 사극 • 전투 • 한국작품").build()
    let playButton: UIButton = ButtonType.common("play.fill", "재생").build()
    let savedButton: UIButton = ButtonType.transparentButton("plus", "내가 찜한 리스트").build()
    lazy var buttonStack: UIStackView = UIStackView(arrangedSubviews: [playButton, savedButton])
    
    let bottomBackground: UIView = BackgroundType.colored.build()
    let bottomLabel: UILabel = LabelType.title("지금 뜨는 콘텐츠").build()
    let firstPoster: UIImageView = ImageViewType.poster("더퍼스트슬램덩크").build()
    let secondPoster: UIImageView = ImageViewType.poster("오펜하이머").build()
    let thirdPoster: UIImageView = ImageViewType.poster("스즈메의문단속").build()
    lazy var bottomPosterStack: UIStackView = UIStackView(arrangedSubviews: [
        firstPoster,
        secondPoster,
        thirdPoster
    ])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        
        configureLayout()
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
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 16
        
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
        bottomPosterStack.axis = .horizontal
        bottomPosterStack.spacing = 8
        bottomPosterStack.distribution = .fillEqually
        
        bottomPosterStack.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom)
                .offset(8)
            make.horizontalEdges.equalTo(bottomBackground.snp.horizontalEdges)
                .inset(8)
            make.bottom.equalTo(bottomBackground)
                .inset(8)
        }
    }
}
