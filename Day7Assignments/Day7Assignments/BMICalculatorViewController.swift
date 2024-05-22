//
//  BMICalculatorViewController.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
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
        .weight(secureTextEntryButtonState) : weightTextFieldBackgroundView
    ]
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    private lazy var textFields: [TextFieldType : UITextField] = [
        .height : heightTextField,
        .weight(secureTextEntryButtonState) : weightTextField
    ]
    
    @IBOutlet var secureEntryButton: UIButton!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var randomBMIButton: UIButton!
    private var secureTextEntryButtonState: ButtonEnabledType = .enabled
    private var calculateButtonState: ButtonEnabledType = .disabled
    private lazy var buttons: [ButtonType : UIButton] = [
        .secureTextEntry(secureTextEntryButtonState) : secureEntryButton,
        .calculate(calculateButtonState): calculateButton,
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
            textField.borderStyle = type.borderStyle
            textField.tag = type.tag
        }
    }
    
    private func configureButtons() {
        buttons.keys.forEach { type in
            setButtonLayout(type)
            
            addTargetToButtons(type)
        }
    }
    
    private func addTargetToButtons(_ type: ButtonType) {
        if let button = buttons[type] {
            button.addTarget(
                self,
                action: #selector(buttonAction),
                for: .touchUpInside
            )
        }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0 : // secureEntry button
            secureTextEntryButtonTapped()
        case 1: // random bmi button
            showAlert(.randomBMIAlert(Double.random(in: 0...1000)))
        case 2: // calculate button
            showAlert(calculateAlertType())
        default:
            break
        }
    }
    
    private func showAlert(_ alertType: AlertType) {
        saveBMIData(.bmi)
        let type = alertType
        let actionTypes: [AlertActionType] = [AlertActionType.cancel]
        
        let alertController = UIAlertController(
            title: type.title,
            message: type.message,
            preferredStyle: type.preferredStyle
        )
        
        actionTypes.forEach { actionType in
            let alertAction = UIAlertAction(
                title: actionType.title,
                style: actionType.style
            )
            alertController.addAction(alertAction)
        }
        
        present(alertController, animated: true)
    }
    
    private func saveBMIData(_ type: KeyType) {
        
    }
    
    private func calculateAlertType() -> AlertType {
        if let height = getCalculatavableValue(.height), // in m
           let weight = getCalculatavableValue(.weight(secureTextEntryButtonState)) { // in kg
            let bmi = weight / pow(height, 2)
            return .bmiAlert(bmi)
        }
        
        return .wrongInputAlert
    }
    
    private func getCalculatavableValue(_ type: TextFieldType) -> Double? {
        guard let textField = textFields[type] else { return nil }
        guard let text = textField.text?.components(separatedBy: " ").first else { return nil }
        guard let decimalNumber = Double(text) else {  return nil }
        
        switch type {
        case .height:
            return convertHeightToCalculatableValue(decimalNumber)
        case .weight:
            return convertWeightToCalculatableValue(decimalNumber)
        }
        
    }
    
    // assume user input is cm. drops any other unit value such as m, km etc...
    private func convertHeightToCalculatableValue(_ decimalNumber: Double) -> Double? {
        switch decimalNumber {
        case 20..<260: // 0.2m~2.6m
            return decimalNumber / 100
        default:
            return nil
        }
    }
    
    // assume user input is kg. drops any other unit value such as g, kg, t etc...
    private func convertWeightToCalculatableValue(_ decimalNumber: Double) -> Double? {
        switch decimalNumber {
        case 1..<500: // 1kg~500kg
            return decimalNumber
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
//            button.isEnabled = type.isEnabled
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
            textField.addTarget(
                self,
                action: #selector(checkTextFieldText),
                for: .editingChanged
            )
            textField.addTarget(
                self,
                action: #selector(addInputUnit),
                for: .editingDidEnd
            )
            textField.addTarget(
                self,
                action: #selector(deleteInputUnit),
                for: .editingDidBegin
            )
        }
    }
    
    @objc private func checkTextFieldText() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let heightText = heightTextField.text,
           let weightText = weightTextField.text {
            if let _ = numberFormatter.number(from: heightText),
                let _ = numberFormatter.number(from: weightText) {
                changeButtonState(to: .calculate(.enabled))
            }
        } else {
            changeButtonState(to: .calculate(.disabled))
        }
    }
    
    @objc private func addInputUnit(_ sender: UITextField) {
        let tag = sender.tag
        var type = TextFieldType.height
        
        if tag != type.tag { // heightTextField
            type = .weight(secureTextEntryButtonState)
        }
        
        addInputUnitFromText(type)
    }
    
    private func addInputUnitFromText(_ type: TextFieldType) {
        if let textField = textFields[type],
           let text = textField.text {
            textField.text = text + " " + type.unit
        }
    }
    
    @objc func deleteInputUnit(_ sender: UITextField) {
        let tag = sender.tag
        var type = TextFieldType.height
        
        if tag != type.tag { // heightTextField
            type = .weight(secureTextEntryButtonState)
        }
        
        deleteInputUnitFromText(type)
    }
    
    private func deleteInputUnitFromText(_ type: TextFieldType) {
        if let textField = textFields[type],
           let text = textField.text {
            let pureText = text.components(separatedBy: " ").first
            textField.text = pureText
        }
    }
    
    private func changeButtonState(to buttonType: ButtonType) {
        changeButtonLayout(buttonType)
        changeButtonEnabled(buttonType)
        
        toggleEnabledProperty(buttonType)
    }
    
    private func changeButtonLayout(_ buttonType: ButtonType) {
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
                button.isEnabled = buttonType.isEnabled
            }
        default:
            break
        }
    }
    
    // change key from .calculate(.disabled) to .calculate(.enabled) and vice versa
    private func toggleEnabledProperty(_ buttonType: ButtonType) {
        buttons.switchKey(buttonType, with: buttonType.toggle())
    }
    
    
    // button actions
    // MARK: Dictionary의 key를 switching 혹은 toggle하는게 현재 너무 복잡함 -> 추후 extension으로 빼거나 다른 방법 사용
    private func secureTextEntryButtonTapped() {
        let toggledState = secureTextEntryButtonState.toggle()
        
        buttons.switchKey(.secureTextEntry(secureTextEntryButtonState), with: .secureTextEntry(toggledState))
        setButtonLayout(.secureTextEntry(toggledState))
        
        textFields.switchKey(.weight(secureTextEntryButtonState), with: .weight(toggledState))
        setTextFieldLayout(.weight(toggledState))
        
        secureTextEntryButtonState = toggledState
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

private enum TextFieldType: CaseIterable, Hashable {
    static var allCases: [TextFieldType] = [
        .height,
        .weight(.enabled)
    ]
    
    case height
    case weight(ButtonEnabledType)
    
    // textField properties
    var placeholder: String {
        switch self {
        case .height:
            return "키를 입력해주세요(cm)"
        case .weight(_):
            return "몸무게를 입력해주세요(kg)"
        }
    }
    
    var borderStyle: UITextField.BorderStyle {
        switch self {
        default:
            return .none
        }
    }
    
    var isSecureEntry: Bool {
        switch self {
        case .weight(let state):
            return (state == .enabled) ? true : false
        default:
            return false
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        default:
            return .numberPad
        }
    }
    
    var unit: String {
        switch self {
        case .height:
            return "cm"
        case .weight(_):
            return "kg"
        }
    }
    
    var tag: Int {
        switch self {
        case .height:
            return 0
        case .weight(_):
            return 1
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
        case .secureTextEntry(_):
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
        case .randomBMI:
            return 1
        case .calculate(_):
            return 2
        }
    }
    
    // enabled disabled properties
    var isEnabled: Bool {
        switch self {
        case .calculate(let buttonEnabledValue), .secureTextEntry(let buttonEnabledValue):
            return buttonEnabledValue.rawValue
        default:
            return true
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
    case randomBMIAlert(Double)
    
    var title: String {
        
        switch self {
        case .bmiAlert(let bmi), .randomBMIAlert(let bmi):
            return "당신의 bmi는 \(String(format: "%.2f", bmi))입니다."
        case .wrongInputAlert:
            return "제대로 된 숫자를 입력해주세요."
        }
    }
    
    var message: String {
        switch self {
        case .bmiAlert(let bmi):
            switch bmi {
            case ..<18.5:
                return "저체중이에요"
            case 18.5..<23:
                return "정상이에요"
            case 23..<25:
                return "비만전단계에요"
            case 25..<30:
                return "1단계 비만이에요"
            case 30..<35:
                return "2단계 비만이에요"
            case 30..<34.9:
                return "3단계 비만이에요"
            default:
                return "제대로된 BMI가 측정되지 않았어요"
            }
        case .wrongInputAlert, .randomBMIAlert(_):
            return "제대로 된 BMI가 측정되지 않았어요"
        }
    }
    
    var preferredStyle: UIAlertController.Style {
        switch self {
        default:
                return .alert
        }
    }
}

private enum AlertActionType {
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


internal enum KeyType {
    case bmi
    
    var forKey: String {
        switch self {
        case .bmi:
            return "bmiCalculator"
        }
    }
    
    var type: Any {
        switch self {
        case .bmi:
            return BMIData.self
        }
    }
}

private struct BMIData {
    let height: Double
    let weight: Double
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


// userdefault로 구현해보고 싶은거
// 1. bmi 날짜 저장 -> spm 사용?
// 2. slimeview reset, 날짜저장 -> 1번과 마찬가지?
// 2. 앱 background로 갈때 자동 저장 -> scenedelegate 사용?
