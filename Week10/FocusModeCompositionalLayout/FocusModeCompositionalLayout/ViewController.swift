//
//  ViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/18/24.
//

import UIKit

class ViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        configuration.backgroundColor = .systemBlue
        
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }


}

