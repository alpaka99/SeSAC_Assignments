//
//  RestaruantTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell, Reusable {

    internal let background: UIView = UIView()
    
    internal let nameLabel: UILabel = UILabel()
    internal let categoryLabel: UILabel = UILabel()
    internal let favoriteButton: UIButton = UIButton()
    
    internal let phoneNumberLabel: UILabel = UILabel()
    
    internal let restaurantImage: UIImageView = UIImageView()
    
    internal var isFavorite: Bool = false
    
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
        setBackgroundUI()
    }
    
    private func configureNameLabel() {
        layoutNamelabel()
        setNameLableUI()
    }
    
    private func configureCategoryLabel() {
        layoutCategoryLabel()
        setCategoryLabelUI()
    }
    
    private func configureFavoriteButton() {
        layoutFavoriteButton()
        setFavoriteButtonUI()
    }
    
    private func configurePhoneNumberLabel() {
        layoutPhoneNumberLabel()
        setPhoneNumerLabelUI()
    }
    
    private func configureRestaurantImage() {
        layoutRestaurantImage()
        setRestaurantImage()
    }
    
    private func layoutBackground() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
    }
    
    
    private func layoutNamelabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
        ])
    }
    
    
    private func layoutCategoryLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
        ])
    }
    
    private func layoutFavoriteButton() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor, multiplier: 1),
        ])
        
    }
    
    
    private func layoutPhoneNumberLabel() {
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor)
        ])
        
    }
    
    
    private func layoutRestaurantImage() {
        restaurantImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            restaurantImage.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            restaurantImage.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            restaurantImage.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
            restaurantImage.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.25),
            restaurantImage.heightAnchor.constraint(equalTo: restaurantImage.widthAnchor, multiplier: 1)
        ])
    }
    
    
    private func setBackgroundUI() {
        background.backgroundColor = .systemGray6
    }
    
    private func setNameLableUI() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        nameLabel.textColor = .systemBlue
    }
    
    private func setCategoryLabelUI() {
        categoryLabel.font = .systemFont(ofSize: 16, weight: .medium)
        categoryLabel.textColor = .systemGray4
    }
    
    private func setFavoriteButtonUI() {
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoriteButton.tintColor = .systemRed
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favoriteButton.tintColor = .systemBlue
        }
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    private func setPhoneNumerLabelUI() {
        phoneNumberLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        phoneNumberLabel.textColor = .black
    }
    
    private func setRestaurantImage() {
        restaurantImage.layer.cornerRadius = 8
        restaurantImage.backgroundColor = .systemGray4
        restaurantImage.clipsToBounds = true
    }
    
    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        setFavoriteButtonUI()
    }
    
    func favoriteChanged() {
        
    }
}
