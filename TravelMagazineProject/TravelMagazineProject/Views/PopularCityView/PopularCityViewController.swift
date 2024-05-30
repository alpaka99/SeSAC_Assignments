//
//  PopularCityViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import Kingfisher
import UIKit

final class PopularCityViewController: UIViewController {
    
    @IBOutlet var popularCitySearchBar: UISearchBar!
    
    @IBOutlet var popularCitySegmentedControl: UISegmentedControl!
    
    @IBOutlet var popularCityCollectionView: UICollectionView!
    
    let popularCitys: [City] = CityInfo().city
    lazy var filteredPopularCitys: [City] = popularCitys
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSegmentedControl()
        configureSearchBar()
        configurePopularCityCollectionView()
    }
    
    private func configureSegmentedControl() {
        popularCitySegmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    
    private func configureSearchBar() {
        popularCitySearchBar.delegate = self
    }
    
    private func configurePopularCityCollectionView() {
        popularCityCollectionView.delegate = self
        popularCityCollectionView.dataSource = self
        
        popularCityCollectionView.showsHorizontalScrollIndicator = false
        popularCityCollectionView.showsVerticalScrollIndicator = false
        
        popularCityCollectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: TestCollectionViewCell.reuseIdentifier)
        popularCityCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
    }
    
    private func configurePopularCitySearchBar() {
        self.popularCitySearchBar.searchTextField.addTarget(self, action: #selector(slideDownKeyboard), for: .editingDidEndOnExit)
    }
    
    private func filterPopularCities(by segment: Int) {
        switch segment {
        case 0:
            filteredPopularCitys = popularCitys
        case 1:
            filteredPopularCitys = popularCitys.filter { city in
                return city.domestic_travel
            }
        case 2:
            filteredPopularCitys = popularCitys.filter { city in
                return !city.domestic_travel
            }
        default:
            return
        }
        
        popularCityCollectionView.reloadData()
    }
    
    @objc
    private func segmentedControlChanged(_ sender: UISegmentedControl) {
        let segment = sender.selectedSegmentIndex
        filterPopularCities(by: segment)
    }
    
    @objc
    func slideDownKeyboard(target: UIView) {
        target.resignFirstResponder()
    }
}


extension PopularCityViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextEntered(searchText)
    }
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            searchTextEntered(searchText)
        }
    }
    
    private func searchTextEntered(_ searchText: String) {
        filterPopularCities(by: popularCitySegmentedControl.selectedSegmentIndex)
        if searchText.isEmpty == false {
            filteredPopularCitys = filteredPopularCitys.filter { city in
                return city.containsSearchText(searchText)
            }
        }
        popularCityCollectionView.reloadData()
    }
}

extension PopularCityViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPopularCitys.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.reuseIdentifier, for: indexPath) as? TestCollectionViewCell {
            let data = filteredPopularCitys[indexPath.row]
            
            cell.configureData(data)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath) as UICollectionViewCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        slideDownKeyboard(target: self.popularCitySearchBar)
    }
}


//extension UILabel {
//    func highlight(searchedText: [String], color: UIColor = .red) {
//        guard let txtLabel = self.text else { return }
//        
//        let attributeText = NSMutableAttributedString(string: txtLabel)
//        
//        searchedText.forEach {
//            let searchedText = $0.lowercased()
//            let range = attributeText.mutableString.range(of: searchedText, options: .caseInsensitive)
//            
//            attributeText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
//        }
//        
//        self.attributedText = attributeText
//    }
//}
