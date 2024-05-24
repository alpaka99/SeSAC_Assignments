//
//  DetailViewController.swift
//  Day4Assignment
//
//  Created by user on 5/19/24.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailImageNameLabel: UILabel!
    @IBOutlet var changeImageButton: UIButton!
    @IBOutlet var detailLabel: UILabel!
    
    var buttonCountDictionary: [EmotionType : Int]!
    var emotions: [EmotionType] = []
    var titleEmotion: EmotionType?
    
    let colors: [UIColor] = [
        .systemPink,
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemGreen,
        .systemCyan,
        .systemBlue,
        .systemIndigo,
    ]
    var randomColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set Layout
        setLayouts()
                
    }
    
    private func setLayouts() {
        getMostFrequentEmotions()
        setRandomColor()
        
        setImageViewLayouts()
        setDetailImageNameLayout()
        setChangeImageButtonLayouts()
        setLabelLayouts()
    }
    
    private func getMostFrequentEmotions() {
        var maxKeys: [EmotionType] = []
        var maxValue: Int = -1
        
        for (key, value) in buttonCountDictionary {
            switch compareWithCurrentMax(
                currentMax: maxValue,
                with: value
            ) {
            case .currentMax:
                break
            case .equal:
                maxKeys.append(key)
            case .newValue:
                maxKeys = [key]
                maxValue = value
            }
        }
        
        emotions = maxKeys
        setTitleEmotion()
    }
    
    private func setRandomColor() {
        randomColor = colors[Int.random(in: 0..<colors.count)]
    }
    
    private func setTitleEmotion() {
        titleEmotion = emotions[Int.random(in: 0..<emotions.count)]
    }
    
    private func setImageViewLayouts() {
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.backgroundColor = .white.withAlphaComponent(0.25)
        detailImageView.layer.cornerRadius = 32
        detailImageView.layer.borderWidth = 4
        detailImageView.layer.borderColor = UIColor.black.cgColor
        
        chageImageViewBackgroundColor()
        changeImageViewImage()
    }
    
    func chageImageViewBackgroundColor() {
        detailImageView.backgroundColor = randomColor
    }
    
    private func setDetailImageNameLayout() {
        detailImageNameLabel.textAlignment = .center
        detailImageNameLabel.font = UIFont.systemFont(
            ofSize: 24, 
            weight: .heavy
        )
        
        changeDetailImageName()
        changeDetailImageBackground()
    }
    
    private func changeDetailImageName() {
        if let titleEmotion = titleEmotion {
            detailImageNameLabel.text = titleEmotion.titleName()
        }
    }
    
    private func changeDetailImageBackground() {
        if let randomColor = randomColor {
            detailImageView.backgroundColor = randomColor.withAlphaComponent(0.7)
        }
    }
    
    private func setChangeImageButtonLayouts() {
        if let randomColor = randomColor {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(systemName: "arrow.clockwise")
            config.background.backgroundColor = randomColor
            config.cornerStyle = .capsule
            
            changeImageButton.configuration = config
            changeImageButton.configurationUpdateHandler = { btn in
                switch btn.state {
                case .highlighted:
                    UIView.animate(withDuration: 0.05, delay: 0) {
                        btn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                default:
                    UIView.animate(withDuration: 0.05, delay: 0) {
                        btn.transform = CGAffineTransform.identity
                    }
                }
            }
            
            changeImageButton.tintColor = .white
        }
    }
    
    private func setLabelLayouts() {
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        detailLabel.font = UIFont.systemFont(
            ofSize: 16,
            weight: .heavy
        )
        
        changeLabelText()
    }
    
    private func changeImageViewImage() {
        if let titleEmotion = titleEmotion {
            detailImageView.image = UIImage(named: titleEmotion.imageName())
        }
    }
    
    private func changeLabelText() {
        var detailLabelText = "당신의 현재 감정은"
        emotions.forEach { emotion in
            detailLabelText += "\n\"\(emotion.titleName())\""
        }
        detailLabelText += "\n입니다...!"
        
        detailLabel.text = detailLabelText
    }
    
    private func compareWithCurrentMax(
        currentMax: Int,
        with number: Int
    ) -> CompareResult {
        if currentMax > number {
            return .currentMax
        } else if currentMax == number {
            return .equal
        } else {
            return .newValue
        }
    }
    
    @IBAction func changeImageButtonTapped(_ sender: UIButton) {
        setTitleEmotion()
        
        setRandomColor()
        chageImageViewBackgroundColor()
        changeImageViewImage()
        changeDetailImageName()
        setChangeImageButtonLayouts()
    }
    
}


private enum CompareResult {
    case currentMax
    case equal
    case newValue
}
