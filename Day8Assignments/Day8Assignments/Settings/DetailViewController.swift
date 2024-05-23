//
//  DetailViewController.swift
//  Day8Assignments
//
//  Created by user on 5/24/24.
//

import UIKit

class DetailViewController: UIViewController {

    let textLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            textLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
    }
    

}
