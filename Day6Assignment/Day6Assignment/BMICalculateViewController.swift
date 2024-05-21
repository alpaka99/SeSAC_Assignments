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
    @IBOutlet var randomBMILabel: UILabel!
    
    private lazy var labels: [LabelType : UILabel] = [
        .title : titleLabel,
        .subTitle : subTitleLabel,
        .heightQuestion : heightQuestionLabel,
        .weightQuestion : weightQuestionLabel,
        .randomBMI : randomBMILabel
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
    private lazy var buttons: [ButtonType : UIButton] = [
        :
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure titleLabels
        configureLabels()
        
        // configure textField Backgrounds
        configureTextFieldBackgrounds()
        
        // configure textFields
        configureTextFields()
        
    }
    
    private func configureLabels() {
        LabelType.allCases.forEach { labelType in
            if let label = labels[labelType] {
                label.text = labelType.text
                label.font = labelType.font
                label.textColor = labelType.textColor
                label.textAlignment = labelType.textAlignment
                label.numberOfLines = labelType.numberOfLines
            }
        }
    }

    private func configureTextFieldBackgrounds() {
        TextFieldType.allCases.forEach { type in
            if let backgroundView = textFieldBackgrounds[type] {
                backgroundView.layer.borderColor = type.borderColor
                backgroundView.layer.borderWidth = type.borderWidth
                backgroundView.layer.cornerRadius = type.cornerRadius
            }
        }
    }
    
    private func configureTextFields() {
        TextFieldType.allCases.forEach { type in
            if let textField = textFields[type] {
                textField.placeholder = type.placeholder
                textField.isSecureTextEntry = type.isSecureEntry
                textField.borderStyle = .none
            }
        }
    }
}


private enum LabelType: CaseIterable {
    case title
    case subTitle
    case heightQuestion
    case weightQuestion
    case randomBMI
    
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
        case .randomBMI:
            return "랜덤으로 BMI 계산하기"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .randomBMI:
            return .red
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
        case .randomBMI:
            return .systemFont(ofSize: 12)
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .randomBMI:
            return .right
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


// MARK: UIButton.configuration을 따라해보려고 했는데 프레임워크처럼 사용법을 고정해놓은 상태면 괜찮지만, 그렇지 않으면 한가지 프로퍼티가 추가되거나 삭제되면 전체 코드를 다 다시짜야함 -> OCP 위반(?)
//private struct LabelConfiguration {
//    let text: String
//    let textColor: UIColor
//    let font: UIFont
//    let textAlignment: NSTextAlignment
//}

