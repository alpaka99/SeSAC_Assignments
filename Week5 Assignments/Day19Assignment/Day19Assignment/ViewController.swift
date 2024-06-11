//
//  ViewController.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

import UIKit

import Alamofire
import SnapKit

class ViewController: UIViewController {
    let searchBar: UISearchBar = UISearchBar()
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    var searchResult: [SearchData] = [] {
        didSet {
            searchResultSet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchResultChanged), name: NSNotification.Name("SearchResult"), object: nil)
    }
}

extension ViewController: CodeBaseBuildable {
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.backgroundColor = .black
        
        collectionView.backgroundColor = .systemIndigo
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchCollectionViewCell.identifier
        )
    }
    
    func configureData<T>(_ data: T) {
        print(#function)
    }
    
    @objc
    func searchResultChanged(_ notification: NSNotification) {
        self.searchResult = SearchManager.shared.searchResult
//        collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell  else { return UICollectionViewCell() }
        
        let data = searchResult[indexPath.row]
        
        cell.configureData(data)
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let width = (ScreenSize.width - 40) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        
        return layout
    }
    
    func searchResultSet() {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.isEmpty == false {
            SearchManager.shared.searchNewData(text)
        }
    }
}


extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.first, lastIndexPath.item - 10 <= SearchManager.shared.searchResult.count {
            if let text = searchBar.text, !text.isEmpty {
                SearchManager.shared.prefetchData(text)
            }
        }
    }
}
