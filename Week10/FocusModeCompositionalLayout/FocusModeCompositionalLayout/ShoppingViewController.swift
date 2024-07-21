//
//  ShoppingViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/20/24.
//

import UIKit

import SnapKit

final class ShoppingViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { collectionView in
            collectionView.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        configureSnapShot()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    func configureDataSource() {
        
    }
    
    func configureSnapShot() {
        
    }
}
