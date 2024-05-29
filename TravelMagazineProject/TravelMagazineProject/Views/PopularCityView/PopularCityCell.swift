//
//  PopularCityCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell, Reusable {
    var cityImage: UIImageView = UIImageView()
    var cityHeader: UILabel = UILabel()
    var cityFooter: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layoutViews()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
        layoutImageView()
        layoutCityHeader()
        layoutCityFooter()
    }
    
    func layoutImageView() {
        self.addSubview(cityImage)
        
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            cityImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cityImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cityImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        
        
        cityImage.backgroundColor = .systemGray4
        cityImage.contentMode = .scaleAspectFill
        cityImage.layer.cornerRadius = 12
        cityImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cityImage.clipsToBounds = true
    }
    
    func layoutCityHeader() {
        cityImage.addSubview(cityHeader)
        
        cityHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityHeader.topAnchor.constraint(equalTo: cityImage.topAnchor, constant: 8),
            cityHeader.leadingAnchor.constraint(equalTo: cityImage.leadingAnchor, constant: 8),
            cityHeader.trailingAnchor.constraint(equalTo: cityImage.trailingAnchor, constant: -8),
        ])
//        
        cityHeader.textAlignment = .right
        cityHeader.textColor = .white
        cityHeader.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    }
    
    func layoutCityFooter() {
        cityImage.addSubview(cityFooter)
        
        cityFooter.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityFooter.leadingAnchor.constraint(equalTo: cityImage.leadingAnchor),
            cityFooter.trailingAnchor.constraint(equalTo: cityImage.trailingAnchor),
            cityFooter.bottomAnchor.constraint(equalTo: cityImage.bottomAnchor),
            cityFooter.heightAnchor.constraint(equalTo: cityImage.heightAnchor, multiplier: 0.2)
        ])
        
        
        cityFooter.textColor = .white
        cityFooter.textAlignment = .left
        cityFooter.backgroundColor = .black.withAlphaComponent(0.5)
        cityFooter.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}

