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
    private lazy var textFieldBackgrounds: [TextFieldType : UIView] = [
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
        .secureTextEntry(.enabled) : secureEntryButton,
        .calculate(.disabled): calculateButton,
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
            setLabelLayout(type)
        }
    }
    
    private func setLabelLayout(_ type: LabelType) {
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
            setTextFieldBackgroundLayout(type)
            setTextFieldLayout(type)
            
            addTargetToTextField(type)
        }
    }
    
    private func setTextFieldBackgroundLayout(_ type: TextFieldType) {
        if let backgroundView = textFieldBackgrounds[type] {
            backgroundView.layer.borderColor = type.borderColor
            backgroundView.layer.borderWidth = type.borderWidth
            backgroundView.layer.cornerRadius = type.cornerRadius
        }
    }
    
    private func setTextFieldLayout(_ type: TextFieldType) {
        if let textField = textFields[type] {
            textField.placeholder = type.placeholder
            textField.isSecureTextEntry = type.isSecureEntry
            textField.borderStyle = .none
        }
    }
    
    private func configureButtons() {
        ButtonType.allCases.forEach { type in
            setButtonLayout(type)
            changeButtonEnabled(type)
        }
        
        addTargetToButtons()
    }
    
    private func addTargetToButtons() {
        buttons.values.forEach { button in
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: // secureEntry button
            secureTextEnteryButtonTapped()
        case 1: // calculate button
            showBMIAlert()
        case 2: // random bmi button
            break
        default:
            break
        }
    }
    
    private func showBMIAlert() {
        let type = calculateAlertType()
        
        let alertController = UIAlertController(title: type.title, message: type.message, preferredStyle: type.preferredStyle)
        let action = UIAlertAction(title: AlertActionType.cancel.title, style: AlertActionType.cancel.style)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    private func calculateAlertType() -> AlertType {
        if let height = getCalculatavableValue(.height), // in m
           let weight = getCalculatavableValue(.weight) { // in kg
            let bmi = weight / pow(height, 2)
            return .bmiAlert(bmi)
        }
        
        return .wrongInputAlert
    }
    
    
    
    private func getCalculatavableValue(_ type: TextFieldType) -> Double? {
        guard let textField = textFields[type] else { return nil }
        guard let text = textField.text else { return nil }
        guard let decimalNumber = Double(text) else {  return nil }
        
        switch type {
        case .height:
            return convertHeightToCalculatableValue(decimalNumber)
        case .weight:
            return convertWeightToCalculatableValue(decimalNumber)
        }
        
    }
    
    // converts cm, m to m
    private func convertHeightToCalculatableValue(_ decimalNumber: Double) -> Double? {
        switch decimalNumber {
        case .leastNonzeroMagnitude..<0.2:
            return nil
        case 0.2..<2.6: // 0.2m~2.6m
            return decimalNumber
        case 3.0..<20:
            return nil
        case 20...260: // 20cm~260cm
            return decimalNumber / 100
        default:
            return nil
        }
    }
    
    // converts g, kg to kg
    private func convertWeightToCalculatableValue(_ decimalNumber: Double) -> Double? {
        switch decimalNumber {
        case .leastNonzeroMagnitude..<1:
            return nil
        case 1..<500: // 1kg~500kg
            return decimalNumber
        case 500..<1000:
            return nil
        case 1000..<500000: // 1000g ~ 500,000g:
            return decimalNumber / 1000
        default:
            return nil
        }
    }
    
    private func setButtonLayout(_ type: ButtonType) {
        if let button = buttons[type] {
            var config = type.config
            config.title = type.title
            config.baseForegroundColor = type.baseForegroundColor
            config.background.backgroundColor = type.backgroundColor
            config.titleAlignment = type.titleAlignment
            config.image = UIImage(systemName: type.buttonSystemImageName)
            
            button.configuration = config
            button.tag = type.tag
        }
    }
    
    private func configureImageViews() {
        ImageViewType.allCases.forEach { type in
            setImageLayout(type)
        }
    }
    
    private func setImageLayout(_ type: ImageViewType) {
        if let imageView = imageViews[type] {
            imageView.image = UIImage(named: type.imageName)?.withRenderingMode(type.withRenderingMode)
            imageView.contentMode = type.contentMode
        }
    }
    
    // textfield actions
    private func addTargetToTextField(_ type: TextFieldType) {
        if let textField = textFields[type] {
            textField.addTarget(self, action: #selector(checkTextFieldText), for: .editingChanged)
        }
    }
    
    @objc private func checkTextFieldText() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let heightText = heightTextField.text,
           let _ = numberFormatter.number(from: heightText),
           let weightText = weightTextField.text,
           let _ = numberFormatter.number(from: weightText) {
            changeButtonState(to: .calculate(.enabled))
        } else {
            changeButtonState(to: .calculate(.disabled))
        }
    }
    
    private func changeButtonState(to buttonType: ButtonType) {
        changeButtonState(buttonType)
        changeButtonEnabled(buttonType)
        //MARK: key로 있는 button type의 disabled 변경해야함
        toggleEnabledProperty(buttonType)
    }
    
    private func changeButtonState(_ buttonType: ButtonType) {
        switch buttonType {
        case .calculate(_), .secureTextEntry(_):
            if let _ = buttons[buttonType] {
                setButtonLayout(buttonType)
            }
        default:
            break
        }
    }
    
    private func changeButtonEnabled(_ buttonType: ButtonType) {
        switch buttonType {
        case .calculate(_):
            if let button = buttons[buttonType] {
                button.isEnabled = buttonType.enabled
            }
        default:
            break
        }
    }
    
    private func toggleSecureTextEntryOption(_ type: ButtonType) {
        changeButtonState(type)
    }
    
    // change key from .calculate(.disabled) to .calculate(.enabled) and vice versa
    private func toggleEnabledProperty(_ buttonType: ButtonType) {
        if let button = buttons.removeValue(forKey: buttonType) {
            buttons[buttonType.toggle()] = button
        }
    }
    
    
    // button actions
    private func secureTextEnteryButtonTapped() {
        if buttons.keys.contains(.secureTextEntry(.enabled)) {
            changeButtonEnabled(.secureTextEntry(.disabled))
        } else {
            changeButtonEnabled(.secureTextEntry(.enabled))
        }
    }
    
    @objc private func calculateButtonTapped() {
        
    }
    
    @objc private func randomBMIButtonTapped() {
        
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
            return "키를 입력해주세요(m)"
        case .weight:
            return "몸무게를 입력해주세요(kg)"
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
        Self.calculate(.disabled),
        Self.randomBMI,
        Self.secureTextEntry(.enabled)
    ]
    
    case secureTextEntry(ButtonEnabledType)
    case calculate(ButtonEnabledType)
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
        case .secureTextEntry(let secureEntryType):
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
        case .randomBMI, .secureTextEntry(.enabled):
            return .red
        case .secureTextEntry(.disabled):
            return .blue
        case .calculate:
            return .white
        }
    }
    
    var baseForegroundColor: UIColor {
        switch self {
        case .secureTextEntry(.enabled), .randomBMI:
            return .red
        case .secureTextEntry(.disabled):
            return .blue
        case .calculate:
            return .white
        }
    }
    
    var title: String? {
        switch self {
        case .secureTextEntry(.enabled):
            return nil
        case .secureTextEntry(.disabled):
            return nil
        case .calculate(.enabled):
            return "결과 확인"
        case .calculate(.disabled):
            return "숫자를 입력해주세요"
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
    
    // other properties
    var tag: Int {
        switch self {
        case .secureTextEntry(_):
            return 0
        case .calculate(_):
            return 1
        case .randomBMI:
            return 2
        }
    }
    
    // enabled disabled properties
    var enabled: Bool {
        switch self {
        case .calculate(let flag), .secureTextEntry(let flag):
            return flag.rawValue
        default:
            return false
        }
    }
    
    func toggle() -> Self {
        switch self {
        case .calculate(let flag):
            return .calculate(flag.toggle())
        case .secureTextEntry(let flag):
            return .secureTextEntry(flag.toggle())
        default:
            return self
        }
    }
}

private enum ButtonEnabledType {
    case enabled
    case disabled
    
    var rawValue: Bool {
        switch self {
        case .enabled:
            return true
        case .disabled:
            return false
        }
    }
    
    func toggle() -> Self {
        switch self {
        case .enabled:
            return .disabled
        case .disabled:
            return .enabled
        }
    }
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

private enum AlertType {
    case bmiAlert(Double)
    case wrongInputAlert
    
    var title: String {
        switch self {
        case .bmiAlert(let bmi):
            return "당신의 bmi는 \(bmi)입니다."
        case .wrongInputAlert:
            return "제대로 된 숫자를 입력해주세요."
        }
    }
    
    var message: String {
        switch self {
        case .bmiAlert(_):
            return "bmi메세지"
        case .wrongInputAlert:
            return "사람이 아니신가요..?"
        }
    }
    
    var preferredStyle: UIAlertController.Style {
        switch self {
        default:
                return .alert
        }
    }
}

enum AlertActionType {
    case cancel
    
    var title: String {
        switch self {
        default:
            return "취소"
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        default:
            return .cancel
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


//func calculateBMI<T: Numeric>(height: T, weight: T) -> T {
//    // bmi 계산 로직
//}
