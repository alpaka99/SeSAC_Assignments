//
//  RandomPosterViewController.swift
//  Day3Assignment
//
//  Created by user on 5/16/24.
//


import UIKit


final class RandomPosterViewController: UIViewController {
    @IBOutlet var mainPoster: UIImageView!
    @IBOutlet var firstMiniPoster: UIImageView!
    @IBOutlet var secondMiniPoster: UIImageView!
    @IBOutlet var thirdMiniPoster: UIImageView!
    
    private lazy var posters: [UIImageView] = [
        mainPoster,
        firstMiniPoster,
        secondMiniPoster,
        thirdMiniPoster
    ]
    
    @IBOutlet var firstBadge: UIImageView!
    @IBOutlet var secondBadge: UIImageView!
    @IBOutlet var thirdBadge: UIImageView!
    
    private lazy var badges: [UIImageView] = [
        firstBadge,
        secondBadge,
        thirdBadge
    ]
    
    @IBOutlet var firstBadgeLabel: UILabel!
    @IBOutlet var secondBadgeLabel: UILabel!
    @IBOutlet var thirdBadgeLabel: UILabel!
    
    lazy var badgeLabels: [UILabel] = [
        firstBadgeLabel,
        secondBadgeLabel,
        thirdBadgeLabel
    ]
    
    @IBOutlet var firstNetflixBadge: UIImageView!
    @IBOutlet var secondNetfilxBadge: UIImageView!
    @IBOutlet var thirdNetflixBadge: UIImageView!
    
    lazy var netflixBadges: [UIImageView] = [
        firstNetflixBadge,
        secondNetfilxBadge,
        thirdNetflixBadge
    ]
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var listButton: UIButton!
    
    private lazy var buttons: [UIButton] = [
        playButton,
        listButton
    ]
    
    
    @IBOutlet var bottomSectionTitleLabel: UILabel!
    
    fileprivate let posterNames: [PosterName] = PosterName.allCases
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // tabBarItem
        setTabBarItem()
        
        // navigationItem
        setNavigationItem()
        
        // posters
        setPosterLayouts()
        
        // buttons
        setButtonLayout()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        setRandomPosterImages()
        randomlyShowDiffrentBadges()
    }
    
    private func setTabBarItem() {
        navigationController?.tabBarItem.image = UIImage(systemName: "house.fill")
        navigationController?.tabBarItem.title = "홈"
    }
    
    private func setNavigationItem() {
        navigationItem.title = "고래밥님"
    }
    
    
    private func setPosterLayouts() {
        setPosterContentMode()
        setPosterBorders()
        setRandomPosterImages()
        roundThePosters()
        
        setBadges()
    }
    
    private func setPosterContentMode() {
        posters.forEach { poster in
            poster.contentMode = .scaleAspectFill
        }
    }
    
    private func setPosterBorders() {
        posters.forEach { poster in
            poster.layer.borderWidth = 1.5
            poster.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    private func roundThePosters() {
        posters.forEach { poster in
            poster.layer.cornerRadius = 20
        }
    }
    
    private func setBadges() {
        setImageBadgesLayouts()
        setBadgeLabelsLayout()
        setNetflixBadges()
        randomlyShowDiffrentBadges()
    }
    
    
    private func setImageBadgesLayouts() {
        badges.forEach { badge in
            badge.image = UIImage(named: "top10 badge")
            badge.contentMode = .scaleAspectFill
            badge.layer.cornerRadius = 10
            badge.layer.maskedCorners = [.layerMaxXMinYCorner]
            
        }
    }
    
    private func setBadgeLabelsLayout() {
        badgeLabels.forEach { badgeLabel in
            badgeLabel.text = "새로운 시리즈"
            badgeLabel.textColor = .white
            badgeLabel.backgroundColor = .systemRed
            badgeLabel.textAlignment = .center
            badgeLabel.font = UIFont.systemFont(ofSize: 10, weight: .black)
        }
    }
    
    private func setNetflixBadges() {
        netflixBadges.forEach { netflixBadge in
            netflixBadge.image = UIImage(named: "single-badge")
            netflixBadge.contentMode = .scaleAspectFit
            netflixBadge.layer.cornerRadius = 20
            netflixBadge.layer.maskedCorners = [.layerMinXMinYCorner]
        }
    }
    
    private func randomlyShowBadges(_ views: [UIView]) {
        views.forEach { view in
            if Int.random(in: 0..<10) % 2 == 0 {
                view.isHidden = true
                view.layer.opacity = 0
            } else {
                view.isHidden = false
                view.layer.opacity = 1
            }
        }
    }
    
    private func randomlyShowDiffrentBadges() {
        randomlyShowBadges(netflixBadges)
        randomlyShowBadges(badges)
        randomlyShowBadges(badgeLabels)
    }
    
    
    
    private func setRandomPosterImages() {
        let randomNumbers: [Int] = Int.randomNumbers(0..<PosterName.allCases.count, numberOfPicks: 4)
        for i in 0..<4 {
            posters[i].image = UIImage(named: PosterName.getRandomMovie(randomNumbers[i]))
        }
    }
    
    private func setButtonLayout() {
        setBottomSectionTitleLabel()
        setPlaybuttonLayout()
        setListButtonLayout()
        commonButtonLayouts()
    }
    
    private func setBottomSectionTitleLabel() {
        bottomSectionTitleLabel.text = "지금 뜨는 컨텐츠"
        bottomSectionTitleLabel.textColor = .white
    }
    
    private func setPlaybuttonLayout() {
        playButton.setImage(
            UIImage(systemName: "play.fill"),
            for: .normal
        )
        playButton.setTitle(
            "재생",
            for: .normal
        )
        playButton.tintColor = .black
        playButton.backgroundColor = .white
    }
    
    private func setListButtonLayout() {
        listButton.setImage(
            UIImage(systemName: "plus"),
            for: .normal
        )
        listButton.setTitle(
            "내가 찜한 리스트",
            for: .normal
        )
        
        listButton.titleLabel?.font = .systemFont(ofSize: 8)
        listButton.tintColor = .white
        listButton.backgroundColor = .darkGray.withAlphaComponent(0.6)
    }
    
    private func commonButtonLayouts() {
        buttons.forEach { button in
            button.layer.cornerRadius = 10
            button.imageEdgeInsets.right = 20
        }
    }
    
    
}




fileprivate enum PosterName: String, CaseIterable {
    case noryang = "노량"
    case slamDunk = "더퍼스트슬램덩크"
    case milsoo = "밀수"
    case crimeCity3 = "범죄도시3"
    case springOfSeoul = "서울의봄"
    case tsuzume = "스즈메의문단속"
    case avatar = "아바타물의길"
    case ophenhimer = "오펜하이머"
    case sixFourFive = "육사오"
    case concreteEutopia = "콘크리트유토피아"
    
    fileprivate func moiveName() -> String {
        return self.rawValue
    }
    
    static func getRandomMovie(_ number: Int) -> String {
//        let randomNumber: Int = Int.random(in: 0..<Self.allCases.count)
        
        switch number {
        case 0:
            return Self.noryang.moiveName()
        case 1:
            return Self.slamDunk.moiveName()
        case 2:
            return Self.milsoo.moiveName()
        case 3:
            return Self.crimeCity3.moiveName()
        case 4:
            return Self.springOfSeoul.moiveName()
        case 5:
            return Self.tsuzume.moiveName()
        case 6:
            return Self.avatar.moiveName()
        case 7:
            return Self.ophenhimer.moiveName()
        case 8:
            return Self.sixFourFive.moiveName()
        case 9:
            return Self.concreteEutopia.moiveName()
        default:
            return Self.slamDunk.moiveName()
        }
    }
}
