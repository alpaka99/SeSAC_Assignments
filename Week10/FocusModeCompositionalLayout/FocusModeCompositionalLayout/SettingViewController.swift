//
//  SettingViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/19/24.
//

import UIKit

import SnapKit

final class SettingViewController: UIViewController {
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
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .systemBlue
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            content.secondaryText = String(indexPath.row)
            content.textProperties.color = .systemOrange
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func configureSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<String, String>()
        
        snapShot.appendSections(["section1", "section2"])
        snapShot.appendItems(["item1", "item2", "item3", "item4"], toSection: "section1")
        snapShot.appendItems(["element1", "element2", "element3"], toSection: "section2")
        
        dataSource.apply(snapShot)
    }
}
