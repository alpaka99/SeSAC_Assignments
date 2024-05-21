//
//  MusicPlayerViewController.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

class MusicPlayerViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var titleIconView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var similarSongsButton: UIButton!
    @IBOutlet var instagramIconButton: UIButton!
    
    @IBOutlet var lyricLabel: UILabel!
    
    
    @IBOutlet var timeLineBar: UIProgressView!
    @IBOutlet var playLoopButton: UIButton!
    @IBOutlet var playShuffleButton: UIButton!
    
    @IBOutlet var playTimeLabel: UILabel!
    @IBOutlet var remainingTimeLabel: UILabel!
    
    private lazy var middleButtons: [MiddleButtonType : UIButton] = [
        .playLoop : playLoopButton,
        .playShuffle : playShuffleButton
    ]
    private lazy var middleTimeLabels: [MiddleLabelType : UILabel] = [
        .playTime : playTimeLabel,
        .remainingTime : remainingTimeLabel
    ]
    
    @IBOutlet var listButton: UIButton!
    @IBOutlet var volumeButton: UIButton!
    
    private lazy var bottomOuterButtons: [BottomOuterButtonType : UIButton] = [
        .list : listButton,
        .volume : volumeButton
    ]
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    private lazy var bottomInnerButtons: [BottomInnerButtonType : UIButton] = [
        .previous : previousButton,
        .play : playButton,
        .next : nextButton
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set background
        setBackgroundImageView("albumBackground")
        
        // set title area
        setTitleArea()
        
        // set album image area
        setAlbumImageArea()
        
        // set lyric label
        setLyricsLabel("가사가사가사가사\n아랫줄가사가사가사가사가사가사")
        
        // set progress area
        setProgressArea()
        
        // set bottom area
        setBottomArea()
    }
    private func setBackgroundImageView(_ imageName: String) {
        backgroundImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.backgroundColor = .black
    }
    
    private func setTitleArea() {
        setTitleIcon()
        setTitle("Spot")
        setSubTitle("Zico(feat Jennie")
    }
    
    private func setTitleIcon() {
        titleIconView.image = UIImage(systemName: "music.note")
        titleIconView.tintColor = .white
    }
    
    private func setTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(
            ofSize: 20,
            weight: .bold
        )
    }
    
    private func setSubTitle(_ subtitle: String) {
        subTitleLabel.text = subtitle
        subTitleLabel.textColor = .white
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = .systemFont(
            ofSize: 12,
            weight: .semibold
        )
    }
    
    private func setAlbumImageArea() {
        setAlbumImage()

        setAlbumImageButtons()
    }
    
    private func setAlbumImage() {
        albumImageView.image = UIImage(named: "albumImage")
        albumImageView.contentMode = .scaleToFill
    }
    
    private func setAlbumImageButtons() {
        setLikeButton()
        setSimilarSongsButton()
        setInstagramButton()
    }
    
    private func setLikeButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.imagePadding = 4
        config.imagePlacement = .leading
        
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .systemFont(ofSize: 12, weight: .regular)
        config.attributedTitle = AttributedString(
            "240,521",
            attributes: attributeContainer
        )
        likeButton.configuration = config
        
        likeButton.tintColor = .white
    }
    
    private func setSimilarSongsButton() {
        var config = UIButton.Configuration.plain()
        
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .systemFont(
            ofSize: 12,
            weight: .regular
        )
        config.attributedTitle = AttributedString(
            "유사곡",
            attributes: attributeContainer
        )
        
        config.cornerStyle = .capsule
        similarSongsButton.configuration = config
        
        similarSongsButton.tintColor = .white
        similarSongsButton.layer.borderColor = UIColor.white.cgColor
        similarSongsButton.layer.borderWidth = 1
        similarSongsButton.layer.cornerRadius = 4
    }
    
    private func setInstagramButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "instagramIcon")?.resizeImage(withSize: instagramIconButton.frame.size)
        config.title = ""
        
        instagramIconButton.configuration = config
    }

    
    private func setLyricsLabel(_ lyrics: String) {
        lyricLabel.text = lyrics
        lyricLabel.textAlignment = .center
        lyricLabel.textColor = .white
        lyricLabel.numberOfLines = 2
        lyricLabel.font = .systemFont(
            ofSize: 16,
            weight: .medium
        )
        
        lyricLabel.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    private func setProgressArea() {
        setTimeLineBar()
        setMiddleButtons()
        setMiddleTimeLabel()
    }
    
    private func setTimeLineBar() {
        timeLineBar.progress = 0.3
        timeLineBar.progressTintColor = .green
        timeLineBar.backgroundColor = .gray
    }
    
    private func setMiddleButtons() {
        middleButtons.keys.forEach { key in
            if let button = middleButtons[key] {
                var config = UIButton.Configuration.plain()
                config.title = ""
                config.image = UIImage(systemName: key.rawValue)
                
                button.configuration = config
                button.tintColor = .gray
            }
        }
    }
    
    private func setMiddleTimeLabel() {
        middleTimeLabels.keys.forEach { key in
            if let timeLabel = middleTimeLabels[key] {
                timeLabel.text = key.getTime()
                timeLabel.font = .systemFont(
                    ofSize: 12,
                    weight: .regular
                )
                timeLabel.textColor = .gray
            }
        }
    }
    
    private func setBottomArea() {
        setBottomOuterButtons()
        setBottomInnerButtons()
    }
    
    private func setBottomOuterButtons() {
        bottomOuterButtons.keys.forEach { key in
            if let button = bottomOuterButtons[key] {
                var config = UIButton.Configuration.plain()
                config.image = UIImage(systemName: key.rawValue)
                var attributeContainer = AttributeContainer()
                attributeContainer.font = UIFont.systemFont(ofSize: 44)
                config.attributedTitle = AttributedString("", attributes: attributeContainer)
                button.configuration = config
                
                button.tintColor = .gray
            }
        }
    }
    
    private func setBottomInnerButtons() {
        bottomInnerButtons.keys.forEach { key in
            if let button = bottomInnerButtons[key] {
                var config = UIButton.Configuration.plain()
                config.image = UIImage(systemName: key.rawValue)
                var attributeContainer = AttributeContainer()
                attributeContainer.font = UIFont.systemFont(ofSize: 60)
                config.attributedTitle = AttributedString("", attributes: attributeContainer)
                button.configuration = config
                
                button.tintColor = .gray
            }
        }
    }
}

private enum MiddleButtonType: String, CaseIterable {
    case playLoop = "arrow.rectanglepath"
    case playShuffle = "shuffle"
}

private enum MiddleLabelType: CaseIterable {
    case playTime
    case remainingTime
    
    func getTime() -> String {
        switch self {
        case .playTime:
            return "0:04"
        case .remainingTime:
            return "1:00"
        }
    }
}

private enum BottomOuterButtonType: String, CaseIterable {
    case list = "list.triangle"
    case volume = "speaker.wave.3"
}

private enum BottomInnerButtonType: String, CaseIterable {
    case previous = "backward.end.fill"
    case play = "pause.fill"
    case next = "forward.end.fill"
}
