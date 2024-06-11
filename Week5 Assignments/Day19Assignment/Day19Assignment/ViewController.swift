//
//  ViewController.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

import UIKit

class ViewController: UIViewController {
    let searchBar: UISearchBar = UISearchBar()
    let collectionView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
}

extension ViewController: CodeBaseBuildable {
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        
    }
    
    func configureUI() {
        <#code#>
    }
    
    func configureData<T>(_ data: T) {
        <#code#>
    }
    
    
}
