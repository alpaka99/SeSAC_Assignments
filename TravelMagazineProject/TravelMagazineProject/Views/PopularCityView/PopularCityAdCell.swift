//
//  PopularCityAdCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

class PopularCityAdCell: UITableViewCell {

    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adBadgeLabel: UILabel!
    
    lazy var labels: [LabelType : UILabel] = [
        .popularCityAdTitle : adTitleLabel,
        .popularCityAdBadge : adBadgeLabel
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        // configureLayout -> done in storyboard
        
        // set Components UI
        setComponentsUI()
    }

    private func setComponentsUI() {
//        setAdTitleLabelUI()
//        setAdBadgeLabelUI()
        setLabelsUI()
    }
    
    private func setLabelsUI() {
        labels.keys.forEach { type in
            if let label = labels[type] {
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
    
    internal func configureData(_ data: Travel) {
        adTitleLabel.text = data.title
        adBadgeLabel.text = "Ad"
    }
}
