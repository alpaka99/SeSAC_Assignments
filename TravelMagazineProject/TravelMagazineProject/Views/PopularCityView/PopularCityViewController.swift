//
//  PopularCityViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import Kingfisher
import UIKit

class PopularCityViewController: UIViewController {
    
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
    }
    
    @objc
    private func segmentedControlChanged(_ sender: UISegmentedControl) {
        let segment = sender.selectedSegmentIndex
        filterPopularCities(by: segment)
    }
    
    private func filterPopularCities(by segment: Int) {
        switch segment {
        case 0:
            filteredPopularCitys = popularCitys
        case 1:
            filteredPopularCitys = popularCitys.filter { city in
                return city.domestic_travel == true
            }
        case 2:
            filteredPopularCitys = popularCitys.filter { city in
                return city.domestic_travel == false
            }
        default:
            return
        }
        
        popularCityCollectionView.reloadData()
    }
}

extension PopularCityViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filterPopularCities(by: popularCitySegmentedControl.selectedSegmentIndex)
        } else {
            filteredPopularCitys = filteredPopularCitys.filter { city in
                return city.city_name.localizedStandardContains(searchText) || city.city_english_name.localizedStandardContains(searchText) || city.city_explain.localizedStandardContains(searchText)
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
            
            if let url = URL(string: data.city_image) {
                cell.cityImage.kf.setImage(with: url)
            }
            cell.cityHeader.text = "\(data.city_name) | \(data.city_english_name)"
            cell.cityFooter.text = data.city_explain
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCollectionViewCell", for: indexPath) as UICollectionViewCell
            
            cell.backgroundColor = .systemOrange
            
            return cell
        }
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
