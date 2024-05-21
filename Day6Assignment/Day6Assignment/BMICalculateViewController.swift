//
//  BMICalculateViewController.swift
//  Day6Assignment
//
//  Created by user on 5/21/24.
//

import UIKit

class BMICalculateViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var heightQuestionLabel: UILabel!
    @IBOutlet var weightQuestionLabel: UILabel!
    private lazy var labels: [LabelType : UILabel] = [
        .title : titleLabel,
        .subTitle : subTitleLabel,
        .heightQuestion : heightQuestionLabel,
        .weightQuestion : weightQuestionLabel
    ]
    
    @IBOutlet var heightTextFieldBackgroundView: UIView!
    @IBOutlet var weightTextFieldBackgroundView: UIView!
    private lazy var textFieldBackgrounds: [ TextFieldType : UIView ] = [
        .height : heightTextFieldBackgroundView,
        .weight : weightTextFieldBackgroundView
    ]
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    private lazy var textFields: [TextFieldType : UITextField] = [
        .height : heightTextField,
        .weight : weightTextField
    ]
    
    @IBOutlet var secureEntryButton: UIButton!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var randomBMIButton: UIButton!
    private lazy var buttons: [ButtonType : UIButton] = [
        .secureEntry(.enabled) : secureEntryButton,
        .calculate: calculateButton,
        .randomBMI: randomBMIButton
    ]
    
    
    @IBOutlet var personImageView: UIImageView!
    private lazy var imageViews: [ImageViewType:UIImageView] = [
        .personImage : personImageView
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure titleLabels
        configureLabels()
        
        // configure textFields
        configureTextFields()
        
        // configure buttons
        configureButtons()
        
        // configure images
        configureImageViews()
    }
    
    private func configureLabels() {
        LabelType.allCases.forEach { type in
            setLabel(type)
        }
    }
    
    private func setLabel(_ type: LabelType) {
        if let label = labels[type] {
            label.text = type.text
            label.font = type.font
            label.textColor = type.textColor
            label.textAlignment = type.textAlignment
            label.numberOfLines = type.numberOfLines
        }
    }

    private func configureTextFields() {
        TextFieldType.allCases.forEach { type in
            setTextFieldBackground(type)
            setTextField(type)
        }
    }
    
    private func setTextFieldBackground(_ type: TextFieldType) {
        if let backgroundView = textFieldBackgrounds[type] {
            backgroundView.layer.borderColor = type.borderColor
            backgroundView.layer.borderWidth = type.borderWidth
            backgroundView.layer.cornerRadius = type.cornerRadius
        }

    }
    
    private func setTextField(_ type: TextFieldType) {
        if let textField = textFields[type] {
            textField.placeholder = type.placeholder
            textField.isSecureTextEntry = type.isSecureEntry
            textField.borderStyle = .none
        }
    }
    
    private func configureButtons() {
        ButtonType.allCases.forEach { type in
            setButton(type)
        }
    }
    
    private func setButton(_ type: ButtonType) {
        if let button = buttons[type] {
            var config = type.config
            config.title = type.title
            config.baseForegroundColor = type.baseForegroundColor
            config.background.backgroundColor = type.backgroundColor
            config.titleAlignment = type.titleAlignment
            config.image = UIImage(systemName: type.buttonSystemImageName)
            
            button.configuration = config
        }
    }
    
    private func configureImageViews() {
        ImageViewType.allCases.forEach { type in
            setImage(type)
        }
    }
    
    private func setImage(_ type: ImageViewType) {
        if let imageView = imageViews[type] {
            imageView.image = UIImage(named: type.imageName)?.withRenderingMode(type.withRenderingMode)
            imageView.contentMode = type.contentMode
        }
    }
}


private enum LabelType: CaseIterable {
    case title
    case subTitle
    case heightQuestion
    case weightQuestion
    
    var text: String {
        switch self {
        case .title:
            return "BMI Calculator"
        case .subTitle:
            return "당신의 BMI 지수를\n알려드릴게요"
        case .heightQuestion:
            return "키가 어떻게 되시나요?"
        case .weightQuestion:
            return "몸무게가 어떻게 되시나요?"
        }
    }
    
    var textColor: UIColor {
        switch self {
            default:
                return .black
        }
    }
    
    var font: UIFont {
        switch self {
        case .title:
            return .systemFont(
                ofSize: 24,
                weight: .bold
            )
        case .subTitle:
            return .systemFont(
                ofSize: 16,
                weight: .regular
            )
        case .heightQuestion, .weightQuestion:
            return .systemFont(
                ofSize: 16,
                weight: .medium
            )
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        default:
            return .left
        }
    }
    
    var numberOfLines: Int {
        switch self {
        case .subTitle, .heightQuestion:
            return 0
        default:
            return 1
        }
    }
}

private enum TextFieldType: CaseIterable {
    case height
    case weight
    
    // textField properties
    var placeholder: String {
        switch self {
        case .height:
            return "키를 입력해주세요"
        case .weight:
            return "몸무게를 입력해주세요"
        }
    }
    
    var borderStyle: UITextField.BorderStyle {
        switch self {
        default:
                .none
        }
    }
    
    
    // background properties
    var borderColor: CGColor {
        switch self {
        default:
            return UIColor.black.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        default:
            return 2.0
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        default:
            return 8
        }
    }
    
    var isSecureEntry: Bool {
        switch self {
        case .weight:
            return true
        default:
            return false
        }
    }
}


private enum ButtonType: CaseIterable, Hashable {
    static var allCases: [ButtonType] = [
        Self.calculate,
        Self.randomBMI,
        Self.secureEntry(.enabled)
    ]
    
    case secureEntry(SecureEntryType)
    case calculate
    case randomBMI
    
    // button style property
    var config: UIButton.Configuration {
        switch self {
        default:
                .plain()
        }
    }
    
    // button image properties
    var buttonSystemImageName: String {
        switch self {
        case .secureEntry(let secureEntryType):
            if secureEntryType == .enabled {
                return "eye.slash"
            } else {
                return "eye.fill"
            }
        default:
            return ""
        }
    }
    
    // button background properties
    var backgroundColor: UIColor {
        switch self {
        case .calculate:
            return .systemPurple
        default:
            return .clear
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .calculate:
            return 8
        default:
            return 0
        }
    }
    
    // button foreground properties
    var tintColor: UIColor {
        switch self {
        case .randomBMI, .secureEntry(.enabled):
            return .red
        case .secureEntry(.disabled):
            return .blue
        case .calculate:
            return .white
        }
    }
    
    var baseForegroundColor: UIColor {
        switch self {
        case .secureEntry(.enabled), .randomBMI:
            return .red
        case .secureEntry(.disabled):
            return .blue
        case .calculate:
            return .white
        }
    }
    
    var title: String? {
        switch self {
        case .secureEntry(.enabled):
            return nil
        case .secureEntry(.disabled):
            return nil
        case .calculate:
            return "결과 확인"
        case .randomBMI:
            return "랜덤으로 BMI 계산하기"
        }
    }
    
    var titleAlignment: UIButton.Configuration.TitleAlignment {
        switch self {
        case .randomBMI:
                .trailing
        default:
                .center
        }
    }
}

private enum SecureEntryType {
    case enabled
    case disabled
}

private enum ImageViewType: CaseIterable {
    case personImage
    
    var imageName: String {
        switch self {
        case .personImage:
            return "image"
        default:
            return ""
        }
    }
    
    var contentMode: UIImageView.ContentMode {
        switch self {
        default:
            return .scaleAspectFill
        }
    }
    
    var withRenderingMode: UIImage.RenderingMode {
        switch self {
        default:
            return .alwaysOriginal
        }
    }
}


// MARK: UIButton.configuration을 따라해보려고 했는데 프레임워크처럼 사용법을 고정해놓은 상태면 괜찮지만, 그렇지 않으면 한가지 프로퍼티가 추가되거나 삭제되면 전체 코드를 다 다시짜야함 -> OCP 위반(?)
//private struct LabelConfiguration {
//    let text: String
//    let textColor: UIColor
//    let font: UIFont
//    let textAlignment: NSTextAlignment
//}

