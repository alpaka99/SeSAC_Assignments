//
//  RestaurantMapViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/30/24.
//

import MapKit
import UIKit

final class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    
    let restuaurantMapView: MKMapView = MKMapView()
    
    let searchBar: UISearchBar = UISearchBar()
    let searchButton: UIButton = UIButton()
    
    let buttonScrollView: UIScrollView = UIScrollView()
    var buttonStackView: UIStackView = UIStackView()
    
    let restaurantList: [Restaurant] = RestaurantList().restaurantArray
    lazy var filteredRestaurantList: [Restaurant] = restaurantList
    
    lazy var filteredAnnotations: [MKAnnotation] = []
    
    lazy var initialMapCenter = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Coordinate.dummyLatitude, longitude: Coordinate.dummyLongitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        layoutMapView()
        layoutSearchBarArea()
        
        layoutButtonScrollView()
        
        
        configureMapData()
        
        restuaurantMapView.region = initialMapCenter
        
        showRestaurantList()
    }
    
    private func layoutMapView() {
        self.view.addSubview(restuaurantMapView)
        
        restuaurantMapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            restuaurantMapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            restuaurantMapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            restuaurantMapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            restuaurantMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func layoutSearchBarArea() {
        layoutSearchBar()
        layoutSearchButton()
    }
    
    private func layoutSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        restuaurantMapView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: restuaurantMapView.topAnchor, constant: ScreenSize.navigationBarConstant),
            searchBar.leadingAnchor.constraint(equalTo: restuaurantMapView.leadingAnchor, constant: 16),
        ])
    }
    
    private func layoutSearchButton() {
        restuaurantMapView.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 16),
            searchButton.trailingAnchor.constraint(equalTo: restuaurantMapView.trailingAnchor, constant: -16),
            searchButton.heightAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 1),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor, multiplier: 1)
        ])
        
        
//        searchButton.backgroundColor = .systemBlue
//        searchButton.setImage(UIImage(systemName: "arrow.turn.up.right"), for: .normal)
//        searchButton.setTitle("길찾기", for: .normal)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        config.image = UIImage(systemName: "arrow.turn.up.right")
        config.title = "길찾기"
        config.titleAlignment = .center
        
        
        searchButton.configuration = config
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .systemBlue
        searchButton.layer.cornerRadius = 8
        
    }
    
    // MARK: 버튼 스크롤뷰 우측 끝으로 이동하면 버튼들이 튕기는 현상
    // MARK: 연산 줄이기
    private func layoutButtonScrollView() {
        for i in 0..<RestaurantList.shared.numberOfCategories {
            let category = RestaurantList.shared.categories[i]
            
            let button = UIButton()
            button.backgroundColor = .white
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.setTitle(category, for: .normal)
            button.setTitleColor(.black, for: .normal)
            
            
            
            button.addTarget(self, action: #selector(filterButtonTapepd), for: .touchUpInside)
            button.tag = i
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 100)
            ])
            
            buttonStackView.addArrangedSubview(button)
        }
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 8
        
        buttonScrollView.addSubview(buttonStackView)
        
        restuaurantMapView.addSubview(buttonScrollView)
        
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonScrollView.frameLayoutGuide.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            buttonScrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            buttonScrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: restuaurantMapView.trailingAnchor),
            buttonScrollView.heightAnchor.constraint(equalTo: restuaurantMapView.heightAnchor, multiplier: 0.1),
            
            
            buttonScrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            buttonScrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 16)
        ])
        
        buttonScrollView.showsHorizontalScrollIndicator = false
        buttonScrollView.alwaysBounceHorizontal = false
        buttonScrollView.alwaysBounceVertical = false
    }
    
    private func configureMapData() {
        configureAnnotations()
        addAnnotationsToMap()
    }
    
    private func configureAnnotations() {
        restuaurantMapView.removeAnnotations(filteredAnnotations)
        filteredAnnotations = []
        filteredRestaurantList.forEach { restaurant in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            filteredAnnotations.append(annotation)
        }
    }
    
    private func addAnnotationsToMap() {
        filteredAnnotations.forEach { annotation in
            restuaurantMapView.addAnnotation(annotation)
        }
    }
    
    
    @objc
    func filterButtonTapepd(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            filterRestaurant(with: text)
        }
    }
    
    private func filterRestaurant(with filter: String) {
        if filter.isEmpty || filter == "전체" {
            filteredRestaurantList = restaurantList
        } else {
            filteredRestaurantList = restaurantList.filter {
                $0.name.localizedStandardContains(filter) || $0.category.localizedStandardContains(filter)
            }
        }
        
        configureMapData()
    }
    
    private func showRestaurantList() {
        let vc = RestaurantViewController()
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        
        self.present(vc, animated: true)
    }
}

