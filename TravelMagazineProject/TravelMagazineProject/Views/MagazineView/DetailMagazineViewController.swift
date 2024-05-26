//
//  DetailMagazineViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class DetailMagazineViewController: UIViewController {
    
    private let textLabel: UILabel = UILabel()
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure test textLabel
        configureTestTextLabel()
    }
    
    private func configureTestTextLabel() {
        self.view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
        
        textLabel.numberOfLines = 0
    }
    
    internal func setTextLabelText(_ text: String) {
        textLabel.text = "URL: \(text)"
    }
    
}
