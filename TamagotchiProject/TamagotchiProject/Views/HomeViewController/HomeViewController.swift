//
//  ViewController.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

import SnapKit

class HomeViewController: UIViewController {
    private let collectionView: UICollectionView = UICollectionView.init(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var tamagotchiData: [Tamagotchi] = TamagotchiManager.shared.tamagotchiData {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(tamagotchiDataChanged), name: NSNotification.Name("TamagotchiData"), object: nil)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCell.identifier, for: indexPath) as? TamagotchiCell else { return UICollectionViewCell() }
        
        guard indexPath.row < tamagotchiData.count else { return cell }
        
        let data = tamagotchiData[indexPath.row]
        
        // MARK: 직접 데이터 전달이 아니라 다른 방법으로 수정이 가능할까?
        cell.configureData(data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: Screen.screenWidth / 3.5, height: Screen.screenWidth / 3)}
        
        let availableSpace = collectionView.bounds.width - (
            flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * 2)
        )
        
        let length = availableSpace / 3
        
        return CGSize(width: length, height: length)
    }
}

extension HomeViewController: CodeBaseBuildable {
    internal func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    internal func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
        }
    }
    
    internal func configureUI() {
        navigationItem.title = "다마고치 선택하기"
        
        view.backgroundColor = UIColor.TGBackgroundColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(TamagotchiCell.self, forCellWithReuseIdentifier: TamagotchiCell.identifier)
        
        collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < tamagotchiData.count {
            let index = indexPath.row
            
            TamagotchiManager.shared.setSelectedTamagotchi(with: self.tamagotchiData[index])
            
            let ac = TGAlertViewController()
            
            ac.tgAlertDelegate = self
            ac.modalPresentationStyle = .overFullScreen
            ac.modalTransitionStyle = .crossDissolve
            
            present(ac, animated: true)
        }
    }
    
    @objc
    func tamagotchiDataChanged() {
        self.tamagotchiData = TamagotchiManager.shared.tamagotchiData
    }
}

extension HomeViewController: TGAlertDelegate {
    func startButtonTapped(_ data: Tamagotchi) {
        let vc = TamagotchiViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UICollectionViewCell: Reusable {
    
}

