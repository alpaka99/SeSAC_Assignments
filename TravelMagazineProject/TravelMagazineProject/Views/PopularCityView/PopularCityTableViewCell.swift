//
//  PopularCityTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

class PopularCityTableViewCell: UITableViewCell {

//    struct Travel {
//        let title: String?
//        let description: String?
//        let travel_image: String?
//        let grade: Double?
//        let save: Int?
//        let like: Bool?
//        let ad: Bool?
//    }

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var cityImageView: UIImageView!
    
    
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // layoutComponents -> done in storyboard
        
        // setComponent UI
        setComponentsUI()
    }
    
    private func setComponentsUI() {
        setTitleLabelUI()
        setDescriptionLabelUI()
        setGradeLabelUI()
        setCityImageViewUI()
    }
    
    private func setTitleLabelUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
    }
    
    private func setDescriptionLabelUI() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        descriptionLabel.textColor = .systemGray3
    }
    
    private func setGradeLabelUI() {
        gradeLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        gradeLabel.textColor = .systemGray4
    }

    private func setCityImageViewUI() {
        cityImageView.layer.cornerRadius = 8
        cityImageView.clipsToBounds = true
        cityImageView.backgroundColor = .systemIndigo
    }
    
    private func setFavoriteButtonUI() {
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .black
        favoriteButton.backgroundColor = .orange
    }
    
}

extension Double {
    func getStars() -> String {
        return "⭐️"
    }
}
