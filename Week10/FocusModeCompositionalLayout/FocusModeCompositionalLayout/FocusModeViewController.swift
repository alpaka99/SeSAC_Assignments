//
//  FocusModeViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/18/24.
//

import UIKit

import SnapKit

class FocusModeViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<Section, Mode.CellData>!
    
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
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Mode.CellData>!
        
        // 어떤 cell의 register 해줄지 여기서 UI 디자인등을 함
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            
            content.text = itemIdentifier.title
            content.textProperties.color = itemIdentifier.textColor
            
            content.image = itemIdentifier.titleIcon
            content.imageProperties.tintColor = itemIdentifier.imageTintColor
            
            content.secondaryText = itemIdentifier.subTitle
            content.secondaryTextProperties.color = itemIdentifier.textColor
            
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .darkGray
            backgroundConfig.cornerRadius = 8
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration = backgroundConfig
            if let trailingView = itemIdentifier.trailingView {
                cell.accessories = [
                    .customView(configuration: .init(
                        customView: trailingView,
                        placement: .trailing(displayed: .always)
                    )),
                ]
                
                if itemIdentifier.isDisclosureShowing {
                    cell.accessories.append(.disclosureIndicator(options: .init(tintColor: .white)))
                }
            }
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    // 여기서 아예 snapShot을 처음부터 다 설정
    // 데이터 타입도 여기서 정해줌
    func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Mode.CellData>()
        
        Section.allCases.forEach { section in
            snapShot.appendSections([section])
            snapShot.appendItems(section.items)
        }
//
        // collectionView에 snapShot을 주는게 아니라, dataSource에 apply를 해주는 방식
        // 그래서 dataSource 변수를 하나 지정해둬야하는거고
        dataSource.apply(snapShot)
    }

}

enum Section: CaseIterable {
    case mode
    case share
    
    var items: [Mode.CellData] {
        switch self {
        case .mode:
            return [Mode.noDistrubMode.data, Mode.sleep.data, Mode.work.data, Mode.privateTime.data]
        case .share:
            return [Mode.shareAcross.data]
        }
    }
}

enum Mode: CaseIterable, Equatable {
    case noDistrubMode
    case sleep
    case work
    case privateTime
    case shareAcross
    
    struct CellData: Hashable, Identifiable {
        let id = UUID()
        let titleIcon: UIImage?
        let imageTintColor: UIColor
        let title: String?
        let subTitle: String?
        let textColor: UIColor
        let trailingView: UIView?
        let isDisclosureShowing: Bool
    }
    
    private var titleIcon: UIImage? {
        switch self {
        case .noDistrubMode:
            return UIImage(systemName: "moon.fill")?.withTintColor(imageTintColor)
        case .sleep:
            return UIImage(systemName: "bed.double.fill")?.withTintColor(imageTintColor)
        case .work:
            return UIImage(systemName: "iphone.gen2.radiowaves.left.and.right")?.withTintColor(imageTintColor)
        case .privateTime:
            return UIImage(systemName: "person.fill")?.withTintColor(imageTintColor)
        case .shareAcross:
            return nil
        }
    }
    
    private var imageTintColor: UIColor {
        switch self {
        case .noDistrubMode:
            return .systemPurple
        case .sleep:
            return .systemOrange
        case .work:
            return .systemGreen
        case .privateTime:
            return .systemBlue
        case .shareAcross:
            return .clear
        }
    }
    
    private var title: String? {
        switch self {
        case .noDistrubMode:
            return "방해 금지 모드"
        case .sleep:
            return "수면"
        case .work:
            return "업무"
        case .privateTime:
            return "개인 시간"
        case .shareAcross:
            return "모든 기기에서 공유"
        }
    }
    
    private var subTitle: String? {
        switch self {
        case .work:
            return "09:00~06:00"
        case .noDistrubMode, .sleep, .privateTime, .shareAcross:
            return nil
        }
    }
    
    private var textColor: UIColor {
        switch self {
        case .noDistrubMode, .sleep, .work, .privateTime, .shareAcross:
            return .white
        }
    }
    
    private var trailingView: UIView? {
        switch self {
        case .noDistrubMode:
            let label = UILabel()
            label.text = "켬"
            label.textColor = self.textColor
            return label
        case .privateTime:
            let label = UILabel()
            label.text = "설정"
            label.textColor = self.textColor
            return label
        case .shareAcross:
            return UISwitch()
        case .sleep, .work:
            return nil
        }
    }
    
    var isDisclosureShowing: Bool {
        switch self {
        case .noDistrubMode, .sleep, .privateTime, .work:
            return true
        case .shareAcross:
            return false
        }
    }
    
    var data: CellData {
        return CellData(
            titleIcon: self.titleIcon,
            imageTintColor: self.imageTintColor,
            title: self.title,
            subTitle: self.subTitle,
            textColor: self.textColor, 
            trailingView: self.trailingView,
            isDisclosureShowing: self.isDisclosureShowing
        )
    }
}
