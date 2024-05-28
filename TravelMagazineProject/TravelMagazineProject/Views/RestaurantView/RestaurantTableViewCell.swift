//
//  RestaruantTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {

    internal let background: UIView = UIView()
    
    internal let nameLabel: UILabel = UILabel()
    internal let categoryLabel: UILabel = UILabel()
    internal let favoriteButton: UIButton = UIButton()
    
    internal let phoneNumberLabel: UILabel = UILabel()
    
    lazy var labels: [LabelType : UILabel] = [
        .restaurantName : nameLabel,
        .restaurantCategory : categoryLabel,
        .restaurantPhoneNumber : phoneNumberLabel
    ]
    
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
        
        // layout
        
        layoutRestaurantCell()
        
        // set UI
        setRestaurantCellUI()
        
        // configure cell data -> call from RestaurantViewController
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func layoutRestaurantCell() {
        layoutBackground()
        layoutNamelabel()
        layoutCategoryLabel()
        layoutPhoneNumberLabel()
        layoutFavoriteButton()
        layoutRestaurantImage()
    }
    
    private func setRestaurantCellUI() {
        setBackgroundUI()
        
//        setNameLableUI()
//        setCategoryLabelUI()
//        setPhoneNumerLabelUI()
        setLabelsUI()
        
//        setFavoriteButtonUI()
        setButtonUI(.favoriteButton(.normal))
        
        setRestaurantImage(.restaurant)
        
        addActions()
    }
    
    private func setLabelsUI() {
        labels.keys.forEach { type in
            if let label = labels[type] {
                label.numberOfLines = type.numberOfLines
                label.textAlignment = type.textAlignment
                label.font = UIFont.systemFont(ofSize: type.fontSize, weight: type.fontWeight)
                label.textColor = type.textColor
            }
        }
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
//        background.backgroundColor = .systemGray6
    }
    
    private func setButtonUI(_ type: ButtonType) {
        favoriteButton.setImage(UIImage(systemName: type.systemName), for: .normal)
        favoriteButton.tintColor = type.tintColor
    }
    
    
//    private func setFavoriteButtonUI() {
//        if isFavorite {
//            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
//            favoriteButton.tintColor = .systemRed
//        } else {
//            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
//            favoriteButton.tintColor = .systemBlue
//        }
//        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
//    }
    
    private func setRestaurantImage(_ type: ImageViewType) {
        restaurantImage.layer.cornerRadius = type.cornerRadius
        restaurantImage.backgroundColor = type.backgroundColor
        restaurantImage.clipsToBounds = type.clipsToBounds
    }
    
    internal func configureCellData(_ data: Restaurant) {
        nameLabel.text = data.name
        categoryLabel.text = data.category
        phoneNumberLabel.text = data.phoneNumber
        
        
        setButtonUI(.favoriteButton(.normal))
        
        if let url = URL(string: data.image) {
            DataManager.shared.fetchImage(url) { [weak self] image in
                self?.restaurantImage.image = image
            }
        }
    }
    
    private func addActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        let type: ButtonType = {
            switch isFavorite {
            case true:
                return .favoriteButton(.pressed)
            case false:
                return .favoriteButton(.normal)
            }
        }()
        
        setButtonUI(type)
    }
}
