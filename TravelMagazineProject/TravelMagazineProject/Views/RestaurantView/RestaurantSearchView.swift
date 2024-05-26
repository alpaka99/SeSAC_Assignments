//
//  RestaruantViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

final class RestaurantSearchView: UIView {
    private let background: UIView = UIView()
    private let textField: UITextField = UITextField()
    private let searchButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(background)
        self.addSubview(textField)
        self.addSubview(searchButton)
        
        // configure background
        configureBackground()
        
        // configure textfield
        configureTextField()
        
        // configure search button
        configureSearchButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        // configure background
    //        configureBackground()
    //
    //        // configure textfield
    //        configureTextField()
    //
    //        // configure search button
    //        configureSearchButton()
    //    }
    
    private func configureBackground() {
        layoutBackground()
        setBackgroundUI()
    }
    
    private func configureTextField() {
        layoutTextField()
    }
    
    private func configureSearchButton() {
        layoutSearchButton()
        setSearchButtonUI()
    }
    
    private func layoutBackground() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setBackgroundUI() {
        background.layer.cornerRadius = 8
        background.layer.borderWidth = 1
        background.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    private func layoutTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
            textField.centerYAnchor.constraint(equalTo: background.centerYAnchor),
        ])
    }
    
    private func setTextFieldUI() {
        textField.borderStyle = .none
        textField.placeholder = "음식점을 검색해보세요..."
        textField.tintColor = .systemGray4
    }
    
    private func layoutSearchButton() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -8),
            searchButton.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalTo: background.heightAnchor, multiplier: 1),
            searchButton.widthAnchor.constraint(equalTo: searchButton.widthAnchor)
        ])
    }
    
    private func setSearchButtonUI() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .systemGreen
    }
    
}
