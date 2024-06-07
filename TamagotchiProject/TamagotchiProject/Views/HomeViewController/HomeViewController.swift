//
//  ViewController.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

import SnapKit

class HomeViewController: UIViewController {
    let collectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCell.identifier, for: indexPath) as? TamagotchiCell else { return UICollectionViewCell() }
        
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
        
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(TamagotchiCell.self, forCellWithReuseIdentifier: TamagotchiCell.identifier)
    }
}



extension UICollectionViewCell: Reusable {
    
}

