//
//  FoodTableViewCell.swift
//  Day7Assignments
//
//  Created by user on 5/27/24.
//

import Kingfisher
import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        // Initialization Code
        super.awakeFromNib()
        configureLayout()
    }
    
    
    func configureLayout() {
        print(#function)
//        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.setPrimaryLabel()
        subTitleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        subTitleLabel.textColor = .darkGray
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.textColor = .blue
    }
    
    func configureCell(_ data: Restaurant) {
        print(#function)
        titleLabel?.text = "\(data.name) | \(data.category)"
        subTitleLabel?.text = data.address
        descriptionLabel?.text = data.price.formatted() + "원"
        
        let url = URL(string: data.image)
        mainImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
        mainImageView.contentMode = .scaleAspectFill
        
    }
    
}
