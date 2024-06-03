//
//  DetailViewController.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailImageNameLabel: UILabel!
    @IBOutlet var changeImageButton: UIButton!
    @IBOutlet var detailLabel: UILabel!
    
    internal var buttonCountDictionary: [EmotionType : Int]!
    private var emotions: [EmotionType] = []
    private var titleEmotion: EmotionType?
    
    // new computed properties
    private var colors: [UIColor] {
        return [ .systemPink,
                 .systemRed,
                 .systemOrange,
                 .systemYellow,
                 .systemGreen,
                 .systemCyan,
                 .systemBlue,
                 .systemIndigo,
            ]
    }
    
    private var randomColor: UIColor? {
        return colors.randomElement()
    }
    
    
    private var detailLabelText: String {
        var detailLabelText = DetailConstants.initialDetailLabelText
        let middleText = emotions.reduce("") { $0+"\n"+"\"\($1.rawValue)\"" }
        detailLabelText += middleText
        detailLabelText += DetailConstants.endDetailLabelText
        
        return detailLabelText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set Layout
        setLayouts()
        
    }
    
    private func setLayouts() {
        getMostFrequentEmotions()
        //        setRandomColor()
        
        setImageViewLayouts()
        setDetailImageNameLayout()
        //        setChangeImageButtonLayouts()
        setLabelLayouts()
        
        changeColorsUsingRandomColor()
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
    
    //    private func setRandomColor() {
    //        randomColor = colors[Int.random(in: 0..<colors.count)]
    //        let randomColor = randomColor
    //        changeDetailImageBackground(with: randomColor)
    
    //    }
    
    private func setTitleEmotion() {
        if let emotion = emotions.randomElement() {
//            titleEmotion = emotions[Int.random(in: 0..<emotions.count)]
            titleEmotion = emotion
        }
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
        //        changeDetailImageBackground()
    }
    
    private func changeDetailImageName() {
        if let titleEmotion = titleEmotion {
            //            detailImageNameLabel.text = titleEmotion.titleName()
            detailImageNameLabel.text = titleEmotion.rawValue
        }
    }
    
    private func changeDetailImageBackground(withColor color: UIColor) {
        //        if let randomColor = randomColor {
        //            detailImageView.backgroundColor = randomColor.withAlphaComponent(0.7)
        //        }
        detailImageView.backgroundColor = color.withAlphaComponent(0.7)
    }
    
    private func setChangeImageButtonLayouts(withColor color: UIColor) {
        //        if let randomColor = randomColor {
        //            var config = UIButton.Configuration.plain()
        //            config.image = UIImage(systemName: "arrow.clockwise")
        //            config.background.backgroundColor = randomColor
        //            config.cornerStyle = .capsule
        //
        //            changeImageButton.configuration = config
        //            changeImageButton.configurationUpdateHandler = { btn in
        //                switch btn.state {
        //                case .highlighted:
        //                    UIView.animate(withDuration: 0.05, delay: 0) {
        //                        btn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        //                    }
        //                default:
        //                    UIView.animate(withDuration: 0.05, delay: 0) {
        //                        btn.transform = CGAffineTransform.identity
        //                    }
        //                }
        //            }
        //
        //            changeImageButton.tintColor = .white
        //        }
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: DetailConstants.buttonConfigurationImageName)
        config.background.backgroundColor = color
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
//        var detailLabelText = "당신의 현재 감정은"
//        emotions.forEach { emotion in
//            detailLabelText += "\n\"\(emotion.titleName())\""
//        }
//        detailLabelText += "\n입니다...!"
        
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
        
        //        setRandomColor()
        chageImageViewBackgroundColor()
        changeImageViewImage()
        changeDetailImageName()
        changeColorsUsingRandomColor()
        //        setChangeImageButtonLayouts()
    }
    
    private func changeColorsUsingRandomColor() {
        if let randomColor = randomColor {
            changeDetailImageBackground(withColor: randomColor)
            setChangeImageButtonLayouts(withColor: randomColor)
        }
    }
    
}


private enum CompareResult {
    case currentMax
    case equal
    case newValue
}
