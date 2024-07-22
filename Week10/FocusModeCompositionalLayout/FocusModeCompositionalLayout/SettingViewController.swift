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
    var dataSource: UICollectionViewDiffableDataSource<SettingSection, SettingCell>!
    
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
        configuration.backgroundColor = .black
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, SettingCell>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier.title
            content.textProperties.color = .white
            
            let backgroundConfig = UIBackgroundConfiguration.clear()
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource<SettingSection, SettingCell>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func configureSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<SettingSection, SettingCell>()
        
        SettingSection.allCases.forEach { section in
            snapShot.appendSections([section])
            snapShot.appendItems(section.items)
        }
        
        dataSource.apply(snapShot)
    }
}

enum SettingSection: Hashable, CaseIterable {
    case totalSection
    case privateSection
    case etcSection
    
    var items: [SettingCell] {
        switch self {
        case .totalSection:
            return [
                SettingCell.notice,
                SettingCell.lab,
                SettingCell.versionInfo,
            ]
        case .privateSection:
            return [
                SettingCell.security,
                SettingCell.notification,
                SettingCell.chatting,
                SettingCell.multiProfie,
            ]
        case .etcSection:
            return [
                SettingCell.customerCenter
            ]
        }
    }
}

enum SettingCell {
    struct CellItem: Identifiable {
        let id = UUID()
        var title: String?
    }
    
    case notice
    case lab
    case versionInfo
    
    case security
    case notification
    case chatting
    case multiProfie
    
    case customerCenter
    
    var title: String? {
        switch self {
        case .notice:
            return "공지사항"
        case .lab:
            return "실험실"
        case .versionInfo:
            return "버전 정보"
        case .security:
            return "개인/보안"
        case .notification:
            return "알림"
        case .chatting:
            return "채팅"
        case .multiProfie:
            return "멀티프로필"
        case .customerCenter:
            return "고객센터/도움말"
        }
    }
    
    var item: CellItem {
        return CellItem(title: title)
    }
}
