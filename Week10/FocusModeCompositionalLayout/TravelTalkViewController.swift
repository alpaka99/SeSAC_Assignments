//
//  TravelTalkViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/21/24.
//

import UIKit

import SnapKit

final class TravelTalkViewController: UIViewController {
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
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        var registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            
            content.text = itemIdentifier
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: collectionView, cellProvider: { collectionView,indexPath,itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    func configureSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<String, String>()
        snapShot.appendSections(["section"])
        snapShot.appendItems(["1", "2"], toSection: "section")
        
        dataSource.apply(snapShot)
    }
}
