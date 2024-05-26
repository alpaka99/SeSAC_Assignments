//
//  RestaruantTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell, Reusable {

    let background: UIView = UIView()
    
    let nameLabel: UILabel = UILabel()
    let categoryLabel: UILabel = UILabel()
    let favoriteButton: UIButton = UIButton()
    
    let phoneNumberLabel: UILabel = UILabel()
    
    let restaurantImage: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(background)
        
        self.background.addSubview(nameLabel)
        self.background.addSubview(categoryLabel)
        self.background.addSubview(favoriteButton)
        
        self.background.addSubview(phoneNumberLabel)
        
        self.background.addSubview(restaurantImage)
        
        
        // configure background
        configureBackground()
        
        // configure nameLabel
        configureNameLabel()
        
        // configure categoryLable
        configureCategoryLabel()
        
        // configure favorite button
        configureFavoriteButton()
        
        // configure phoneNumberLable
        configurePhoneNumberLabel()
        
        // configure restaurantImage
        configureRestaurantImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackground() {
        layoutBackground()
    }
    
    private func configureNameLabel() {
        layoutNamelabel()
    }
    
    private func configureCategoryLabel() {
        layoutCategoryLabel()
    }
    
    private func configureFavoriteButton() {
        layoutFavoriteButton()
    }
    
    private func configurePhoneNumberLabel() {
        layoutPhoneNumberLabel()
    }
    
    private func configureRestaurantImage() {
        layoutRestaurantImage()
    }
    
    private func layoutBackground() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
        background.backgroundColor = .gray
    }
    
    
    
    private func layoutNamelabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
        ])
        nameLabel.text = "음식점 이름"
    }
    
    
    private func layoutCategoryLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
        ])
        categoryLabel.text = "초밥집"
    }
    
    private func layoutFavoriteButton() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: 8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor, multiplier: 1),
        ])
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    
    private func layoutPhoneNumberLabel() {
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor)
        ])
        
        phoneNumberLabel.text = "010-1234-5678"
    }
    
    
    private func layoutRestaurantImage() {
        restaurantImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            restaurantImage.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            restaurantImage.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            restaurantImage.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
            restaurantImage.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.25),
            restaurantImage.heightAnchor.constraint(equalTo: restaurantImage.widthAnchor, multiplier: 1.25)
        ])
        
        restaurantImage.backgroundColor = .blue
    }
}
