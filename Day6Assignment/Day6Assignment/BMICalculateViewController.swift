//
//  BMICalculateViewController.swift
//  Day6Assignment
//
//  Created by user on 5/21/24.
//

import UIKit

class BMICalculateViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTItleLabel: UILabel!
    private lazy var titleLabels: [TitleLabelType : UILabel] = [
        .title : titleLabel,
        .subTitle : subTItleLabel
    ]
    
    @IBOutlet var heightQuestionLabel: UILabel!
    @IBOutlet var heightQeustionTextField: UITextField!
    
    
    @IBOutlet var weightQuestionLabel: UILabel!
    @IBOutlet var weightQuestionTextField: UITextField!
    
    @IBOutlet var randomBMILabel: UILabel!
    @IBOutlet var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure titleLabels
        configureTitleLabels()
        
        
    }
    
    private func configureTitleLabels() {
        TitleLabelType.allCases.forEach { key in
            if let label = titleLabels[key] {
                let config = key.info
                
                label.text = config.text
                label.font = config.font
                label.textColor = config.textColor
                label.textAlignment = config.textAlignment
                label.numberOfLines = 0
            }
        }
    }

}


private enum TitleLabelType: CaseIterable {
    case title
    case subTitle
    
    var info: LabelConfiguration {
        switch self {
        case .title:
            return LabelConfiguration(
                text: "BMI Calculator",
                textColor: .black,
                font: .systemFont(ofSize: 28, weight: .bold),
                textAlignment: .left
            )
        case .subTitle:
            return LabelConfiguration(
                text: "당신의 BMI 지수를\n알려드릴게요",
                textColor: .black,
                font: .systemFont(ofSize: 16, weight: .medium),
                textAlignment: .left
            )
        }
    }
}


private struct LabelConfiguration {
    let text: String
    let textColor: UIColor
    let font: UIFont
    let textAlignment: NSTextAlignment
}
