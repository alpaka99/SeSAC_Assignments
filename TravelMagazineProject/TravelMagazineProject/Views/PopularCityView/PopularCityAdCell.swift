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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        // configureLayout -> done in storyboard
        
        // set Components UI
        setComponentsUI()
    }

    private func setComponentsUI() {
        setAdTitleLabelUI()
        setAdBadgeLabelUI()
    }
    
    private func setAdTitleLabelUI() {
        adTitleLabel.numberOfLines = 0
        adTitleLabel.textAlignment = .center
        adTitleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        adTitleLabel.textColor = .black
        let randomColor = UIColor.getRandomColor()
        adTitleLabel.backgroundColor = randomColor
        adTitleLabel.layer.cornerRadius = 8
        adTitleLabel.clipsToBounds = true
    }
    
    private func setAdBadgeLabelUI() {
        adBadgeLabel.text = "Ad"
        adBadgeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        adBadgeLabel.textAlignment = .center
        adBadgeLabel.textColor = .black
        adBadgeLabel.layer.cornerRadius = 4
        adBadgeLabel.backgroundColor = .white
        adBadgeLabel.clipsToBounds = true
    }
    
    internal func configureData(_ data: Travel) {
        adTitleLabel.text = data.title
    }
}
