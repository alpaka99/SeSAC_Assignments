//
//  TravelCityAdDetailViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit

final class DetailAdViewController: UIViewController, Reusable {
    
    let detailAdTitle: UILabel = UILabel()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        
        layoutViews()
    }
    
    private func layoutViews() {
        layoutDetailTitle()
    }
    
    private func layoutDetailTitle() {
        self.view.addSubview(detailAdTitle)
        
        detailAdTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailAdTitle.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailAdTitle.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailAdTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailAdTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        detailAdTitle.text = "광고 화면"
        detailAdTitle.textAlignment = .center
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "광고 화면"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(pop))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}
