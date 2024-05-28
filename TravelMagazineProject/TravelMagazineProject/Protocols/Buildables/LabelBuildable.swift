//
//  LabelBuildable.swift
//  TravelMagazineProject
//
//  Created by user on 5/28/24.
//

import UIKit

protocol LabelBuildable {
    var labels: [LabelType : UILabel] { get set }
    func buildLabelsUI()
}


extension LabelBuildable {
    func buildLabelsUI() {
        self.labels.keys.forEach { labelType in
            buildLabelUI(labelType)
        }
    }
    
    func buildLabelUI(_ labelType: LabelType) {
        if let label = self.labels[labelType] {
            label.numberOfLines = labelType.numberOfLines
            label.textAlignment = labelType.textAlignment
            label.font = UIFont.systemFont(ofSize: labelType.fontSize, weight: labelType.fontWeight)
            label.textColor = labelType.textColor
            label.backgroundColor = labelType.backgroundColor
            label.layer.cornerRadius = labelType.cornerRadius
            label.clipsToBounds = labelType.clipsToBounds
        }
    }
}
