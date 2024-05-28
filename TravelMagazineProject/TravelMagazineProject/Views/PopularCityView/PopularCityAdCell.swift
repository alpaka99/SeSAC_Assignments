//
//  PopularCityAdCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

class PopularCityAdCell: PopularCityBuildableAdCell {

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
        buildLabelsUI()
    }
    
    internal func configureData(_ data: Travel) {
        adTitleLabel.text = data.title
        adBadgeLabel.text = AdBadgeCell.text
    }
}
