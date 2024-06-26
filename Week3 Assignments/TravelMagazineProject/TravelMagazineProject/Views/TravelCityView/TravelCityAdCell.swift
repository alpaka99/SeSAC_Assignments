//
//  TravelCityAdCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

class TravelCityAdCell: UITableViewCell, LabelBuildable {

    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adBadgeLabel: UILabel!
    
    lazy var labels: [LabelType : UILabel] = [
        .travelCityAdTitle : adTitleLabel,
        .travelCityAdBadge : adBadgeLabel
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
