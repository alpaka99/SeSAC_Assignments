//
//  TravelTalkViewController.swift
//  FocusModeCompositionalLayout
//
//  Created by user on 7/21/24.
//

import UIKit

import SnapKit

final class TravelTalkViewController: UIViewController {
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<TravelTalkSection, TravelTalkCellData>!
    
    var talkData: [TravelTalkCellData] =  []
    
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
        
        searchBar.placeholder = "친구 이름을 검색해보세요"
        configureDataSource()
        configureSnapShot()
    }
    
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        var registration = UICollectionView.CellRegistration<UICollectionViewListCell, TravelTalkCellData>(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            
            content.text = itemIdentifier.nickname
            content.textProperties.color = .black
            content.textProperties.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            
            content.secondaryText = itemIdentifier.talk
            content.secondaryTextProperties.color = .darkGray
            content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            
            
            let profileImage = ProfileImageView()
            profileImage.image.image = UIImage(named: itemIdentifier.nickname)
            let dateLabel = DateLabel()
            dateLabel.label.text = itemIdentifier.date.formatted()
            
            cell.accessories = [
                .customView(configuration: .init(customView: profileImage, placement: .leading(displayed: .always))),
                .customView(configuration: .init(customView: dateLabel, placement: .trailing(displayed: .always)))
            ]
            
            cell.contentConfiguration = content
        })
        
        dataSource = UICollectionViewDiffableDataSource<TravelTalkSection, TravelTalkCellData>(collectionView: collectionView, cellProvider: { collectionView,indexPath,itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    func configureSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<TravelTalkSection, TravelTalkCellData>()
        snapShot.appendSections([.normal])
        snapShot.appendItems([
            TravelTalkCellData(nickname: "Hue", talk: "왜요? 요즘 코딩이 대세인데", date: Date()),
            TravelTalkCellData(nickname: "Jack", talk: "깃허브는 푸시하셨나여?", date: Date()),
            TravelTalkCellData(nickname: "Bran", talk: "과제 화이팅!", date: Date()),
            TravelTalkCellData(nickname: "Den", talk: "벌써 퇴근하세요?ㅎㅎㅎㅎㅎ", date: Date()),
            TravelTalkCellData(nickname: "내옆자리의앞자리에개발잘하는친구", talk: "내일 모닝콜 해주실분~~", date: Date()),
            TravelTalkCellData(nickname: "심심이", talk: "아닛 주말과제라닛", date: Date()),
            
        ], toSection: .normal)
        
        dataSource.apply(snapShot)
    }
    
    enum TravelTalkSection {
        case normal
    }
    
    struct TravelTalkCellData: Hashable, Identifiable {
        let id = UUID()
        let nickname: String
        let talk: String
        let date: Date
    }
}

final class DateLabel: UIView {
    let label = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.snp.makeConstraints { label in
            label.top.horizontalEdges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ProfileImageView: UIView {
    let image = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(image)
        image.snp.makeConstraints { img in
            img.size.equalTo(40)
            img.center.equalTo(self.snp.center)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        image.layer.cornerRadius = image.frame.width / 2
    }
}
