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
        
        layoutComponents()
        
        configureComponents()
    }
    
    private func layoutComponents() {
        layoutMap()
    }
    
    private func configureComponents() {
        configureNavigationItem()
        configureMap()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "SeSAC Restaurant"
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(annotationListButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
    
    @objc
    func annotationListButtonTapped() {
        let annotationAlert = UIAlertController(title: "filter options", message: "choose filter option", preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "option1", style: .default) { _ in
            print("option1")
        }
        annotationAlert.addAction(option1)
        
        let option2 = UIAlertAction(title: "option2", style: .default) { _ in
            print("option2")
        }
        annotationAlert.addAction(option2)
        
        let option3 = UIAlertAction(title: "option3", style: .default) { _ in
            print("option3")
        }
        annotationAlert.addAction(option3)
        
        let option4 = UIAlertAction(title: "option4", style: .default) { _ in
            print("option4")
        }
        annotationAlert.addAction(option4)
        
        let option5 = UIAlertAction(title: "option5", style: .default) { _ in
            print("option5")
        }
        annotationAlert.addAction(option5)
        
        present(annotationAlert, animated: true)
    }
}
