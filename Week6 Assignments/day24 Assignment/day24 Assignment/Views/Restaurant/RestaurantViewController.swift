//
//  RestaurantViewController.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import CoreLocation
import MapKit
import UIKit

import SnapKit

final class RestaurantViewController: UIViewController {
    let mapView = MKMapView()
    let userLocationButton = UIButton()
        .image(systemName: ImageName.targetImage)
        .tintColor(with: .white)
        .backgroundColor(with: .systemBlue)
        .cornerStyle(style: .capsule)
    
    let restaurants: [Restaurant] = RestaurantList().restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        LocationStore.shared.checkLocationAvailabilty()
    }
    
    func configureHierarchy() {
        view.addSubview(mapView)
        view.addSubview(userLocationButton)
    }
    
    func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        userLocationButton.snp.makeConstraints {
            $0.leading.equalTo(mapView.snp.leading)
                .offset(20)
            $0.bottom.equalTo(mapView.snp.bottom)
                .offset(-20)
            $0.size.equalTo(44)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "식당 정보 검색하기"
        
        mapView.showsUserLocation = true
        
        userLocationButton.addTarget(
            self,
            action: #selector(userLocationButtonTapped),
            for: .touchUpInside
        )
        
        addRestaurantAnnotations(restaurants)
    }
    
    @objc
    func userLocationButtonTapped(_ sender: UIButton) {
        let coordinateRegion = MKCoordinateRegion(
            center: LocationStore.shared.fetchCurrentLocation(),
            latitudinalMeters: 400,
            longitudinalMeters: 400
        )
        
        mapView.region = coordinateRegion
    }
    
    func addRestaurantAnnotations(_ restaurants: [Restaurant]) {
        var restaurantAnnotations: [MKPointAnnotation] = []
        
        for restaurant in restaurants {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: restaurant.latitude,
                longitude: restaurant.longitude
            )
            annotation.title = restaurant.name
            
            restaurantAnnotations.append(annotation)
        }
        
        mapView.addAnnotations(restaurantAnnotations)
    }
}
