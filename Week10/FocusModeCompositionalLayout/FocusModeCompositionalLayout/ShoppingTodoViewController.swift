//
//  ShoppingTodoViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/21/24.
//

import UIKit

import SnapKit

final class ShoppingTodoViewController: UIViewController {
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<ShoppingTodoSection, ShoppingTodoCellData>!
    
    var shoppingTodoCellDatas: [ShoppingTodoCellData] = [
        ShoppingTodoCellData(checked: true, title: "그립톡 구매하기", favorite: true),
        ShoppingTodoCellData(checked: false, title: "사이다 구매", favorite: false),
        ShoppingTodoCellData(checked: false, title: "아이패드 케이스 최저가 알아보기", favorite: true),
        ShoppingTodoCellData(checked: false, title: "양말", favorite: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        searchBar.snp.makeConstraints { searchBar in
            searchBar.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(searchBar.snp.bottom)
            collectionView.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
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
        var registration = UICollectionView.CellRegistration<UICollectionViewListCell, ShoppingTodoCellData> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            
            content.text = itemIdentifier.title
            if itemIdentifier.checked {
                content.image = UIImage(systemName: "checkmark.square.fill")?.withTintColor(.black)
            } else {
                content.image = UIImage(systemName: "checkmark.square")?.withTintColor(.black)
            }
            
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.backgroundColor = .systemGray4
            background.cornerRadius = 8
            
            let accessoryView = UIImageView(image: UIImage(systemName: "star")?.withTintColor(.black))
            if itemIdentifier.favorite {
                accessoryView.image = UIImage(systemName: "star.fill")?.withTintColor(.black)
            }
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration = background
            cell.accessories = [
                .customView(configuration: .init(customView: accessoryView, placement: .trailing(displayed: .always)))
            ]
        }
        
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            
            
            
            return cell
        })
    }
    
    func configureSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<ShoppingTodoSection, ShoppingTodoCellData>()
        snapShot.appendSections(ShoppingTodoSection.allCases)
        snapShot.appendItems(shoppingTodoCellDatas, toSection: .todos)
        
//
        dataSource.apply(snapShot)
    }
}

enum ShoppingTodoSection: CaseIterable {
    case todos
}

struct ShoppingTodoCellData: Identifiable, Hashable {
    let id = UUID()
    let checked: Bool
    let title: String
    let favorite: Bool
}
