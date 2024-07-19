//
//  ViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/18/24.
//

import UIKit

import SnapKit

struct CellData: Hashable, Identifiable {
    let id = UUID()
    let title: String = "Test"
}

class ViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<String, CellData>!
    
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        configuration.backgroundColor = .black
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { collectionView in
            collectionView.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        updateSnapShot()
        
    }

    private func configureDataSource() {
        // cell Registration
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, CellData>!
        
        // 어떤 cell의 register 해줄지 여기서 UI 디자인등을 함
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = "test"
            content.textProperties.color = .white
            content.image = UIImage(systemName: "star")
            content.imageProperties.tintColor = .systemRed
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .clear
            backgroundConfig.cornerRadius = 8
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration = backgroundConfig
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    // 여기서 아예 snapShot을 처음부터 다 설정
    // 데이터 타입도 여기서 정해줌
    func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<String, CellData>()
        
        snapShot.appendSections(["Test1", "Test2"])
        snapShot.appendItems([CellData(), CellData(), CellData(), CellData()], toSection: "Test1")
        
        // collectionView에 snapShot을 주는게 아니라, dataSource에 apply를 해주는 방식
        // 그래서 dataSource 변수를 하나 지정해둬야하는거고
        dataSource.apply(snapShot)
    }

}

