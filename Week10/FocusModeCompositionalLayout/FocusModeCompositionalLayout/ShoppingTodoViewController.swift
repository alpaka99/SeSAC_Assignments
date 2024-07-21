//
//  ShoppingTodoViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/21/24.
//

import UIKit

import SnapKit

final class ShoppingTodoViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<String, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { collectionView in
            collectionView.edges.equalTo(view.safeAreaLayoutGuide)
        }
        configureDataSource()
        configureSnapShot()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        var registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            
            content.text = itemIdentifier
            
            cell.contentConfiguration = content
        }
        
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    func configureSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<String, String>()
        snapShot.appendSections(["1", "2"])
        snapShot.appendItems(["12", "34"], toSection: "1")
        snapShot.appendItems(["34", "56"], toSection: "2")
        
        dataSource.apply(snapShot)
    }
}
