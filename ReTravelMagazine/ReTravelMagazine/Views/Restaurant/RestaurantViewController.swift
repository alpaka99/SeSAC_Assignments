//
//  RestaurantViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import CoreLocation
import MapKit
import UIKit

final class RestaurantViewController: UIViewController {
    
    private let map: MKMapView = MKMapView()
    private let restaurants: [Restaurant] = RestaurantList().restaurantArray
    private lazy var filteredRestaurant: [Restaurant] = [] {
        didSet {
            self.removeAllExistingAnnotations()
            self.addFilteredAnnotations()
        }
    }
    private var filterSheet: UIAlertController = UIAlertController()
    private lazy var initialRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: MapConstants.initialCenter,
        latitudinalMeters: MapConstants.dummyLatitudinalMeters,
        longitudinalMeters: MapConstants.dummyLongitudinalMeters
    )
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutComponents()
        
        configureComponents()
    }
    
    private func layoutComponents() {
        layoutMap()
    }
    
    private func configureComponents() {
        configureNavigationItem()
        configureMap()
        configureFilterAlert()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "SeSAC Restaurant"
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(annotationListButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func configureMap() {
        map.delegate = self
        
        map.region = initialRegion
        filteredRestaurant = restaurants
    }
    
    private func configureFilterAlert() {
        FilterOption.allCases.forEach { option in
            let action = UIAlertAction(title: option.rawValue, style: option.style) { [weak self] _ in
                self?.filterRestaurants(with: option)
            }
            
            filterSheet.addAction(action)
        }
    }
    
    private func filterRestaurants(with option: FilterOption) {
        switch option {
        case .total:
            filteredRestaurant = restaurants
        case .cafe, .chinese, .japanese, .korean, .semiWestern, .snack, .western:
            filteredRestaurant = restaurants.filter {
                option == FilterOption.init(rawValue: $0.category)
            }
        case .cancel:
            break
        }
    }
    
    private func layoutMap() {
        self.view.addSubview(map)
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.view.topAnchor),
            map.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    @objc
    func annotationListButtonTapped() {
        present(filterSheet, animated: true)
    }
    
    private func removeAllExistingAnnotations() {
        map.removeAnnotations(map.annotations)
    }
    
    private func addFilteredAnnotations() {
        filteredRestaurant.forEach { restaurant in
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = restaurant.coordinate
            pointAnnotation.title = restaurant.name
            
            map.addAnnotation(pointAnnotation)
        }
    }
}


extension RestaurantViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            map.setRegion(
                MKCoordinateRegion(
                    center: coordinate,
                    latitudinalMeters: MapConstants.dummyLatitudinalMeters,
                    longitudinalMeters: MapConstants.dummyLongitudinalMeters
                ),
                animated: true
            )
        }
    }
}

//한식 일식 양식 중식 경양식 분식 카페
enum FilterOption: String, CaseIterable {
    case total = "전체"
    case korean = "한식"
    case japanese = "일식"
    case western = "양식"
    case chinese = "중식"
    case semiWestern = "경양식"
    case snack = "분식"
    case cafe = "카페"
    case cancel = "취소"
    
    var style: UIAlertAction.Style {
        switch self {
            
        case .total, .korean, .japanese, .western, .chinese, .semiWestern, .snack, .cafe:
            return .default
        case .cancel:
            return .cancel
        }
    }
}



