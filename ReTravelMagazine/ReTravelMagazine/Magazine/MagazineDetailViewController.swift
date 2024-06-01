//
//  MagazineDetailViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

final class MagazineDetailViewController: UIViewController {
    
    let titleLabel: UILabel = UILabel()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTitleLabel()
    }
    
    private func layoutTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        titleLabel.text = "detail title"
    }
    
    
}
