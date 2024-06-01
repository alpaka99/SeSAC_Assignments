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
        
        navigationItem.title = "SeSAC Restaurant"
        
        layoutComponents()
        
        configureComponents()
    }
    
    private func layoutComponents() {
        layoutMap()
    }
    
    private func configureComponents() {
        configureMap()
    }
    
    private func configureMap() {
        map.region = initialRegion
        
        placeAnnotations()
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
    
    private func placeAnnotations() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = MapConstants.initialCenter
        
        annotation.title = "SeSAC iOS"
        
        map.addAnnotation(annotation)
    }
}
