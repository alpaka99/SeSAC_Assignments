//
//  ViewController.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        let view = UIView()
        view.backgroundColor = .systemOrange
        
        self.view = view
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemOrange
        
        title  = "plz"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(#function)
    }

}

