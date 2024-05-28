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
        self.labels.keys.forEach { type in
            if let label = self.labels[type] {
                label.numberOfLines = type.numberOfLines
                label.textAlignment = type.textAlignment
                label.font = UIFont.systemFont(ofSize: type.fontSize, weight: type.fontWeight)
                label.textColor = type.textColor
                label.backgroundColor = type.backgroundColor
                label.layer.cornerRadius = type.cornerRadius
                label.clipsToBounds = type.clipsToBounds
            }
        }
    }
}
