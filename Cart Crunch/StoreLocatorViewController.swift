//  StoreLocatorViewController.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/17/23.
//  Created by Jonathan Velez on 4/20/23
//

import UIKit
import MapKit
import CoreLocation


class StoreLocatorViewController: UIViewController, CLLocationManagerDelegate {
    private let networkManager = NetworkManager()
    private let manager = CLLocationManager()
    private lazy var locationManager = LocationManager(networkManager: networkManager)
    private var fetchedStores: [Store] = []

        // MARK: - UI Components
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
 
    private let watchListButton: UIButton = {
        let button = UIButton()
        button.setTitle("List View", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 5
        return button
    }()
    
        // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setupUI()
        updateMapView()
        addButtonTargets()
        
        view.backgroundColor = .blue
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        locationManager.requestUserLocation()
    }

        // MARK: - CLLocationManagerDelegate
    // location manager gets location of the user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            NetworkManager.shared.fetchNearbyStores(latitude: latitude, longitude: longitude) { [weak self] result in
                switch result {
                    case .success(let stores):
                        DispatchQueue.main.async {
                            self?.fetchedStores = stores
                            print("Fetched stores: \(stores)")
                            self?.createAnnotations(stores: stores)
                            self?.fitAllAnnotations()
                        }
                    case .failure(let error):
                        print("Error fetching stores:", error)
                }
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else if status == .denied || status == .restricted {
            print("denied")
        }
    }

    // will render the map to the users area
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
        // MARK: - Map Rendering and Annotations
    func fitAllAnnotations() {
        let annotations = mapView.annotations.filter { !$0.isEqual(mapView.userLocation) }
        if annotations.count > 1 {
            var zoomRect = MKMapRect.null
            for annotation in annotations {
                let annotationPoint = MKMapPoint(annotation.coordinate)
                let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
                zoomRect = zoomRect.union(pointRect)
            }
            mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        } else if annotations.count == 1 {
            let coordinate = CLLocationCoordinate2D(latitude: annotations[0].coordinate.latitude, longitude: annotations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

        //create our annotations on the map
    func createAnnotations(stores: [Store]){
        mapView.removeAnnotations(mapView.annotations) // remove previous annotations
        for store in stores {
            let annotations = MKPointAnnotation()
            
            annotations.title = store.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: store.geolocation.latitude , longitude: store.geolocation.longitude)
            
            mapView.addAnnotation(annotations)
        }
    }
    
        // MARK: - UI Setup
    // uiset up for buttons and mapview
    private func setupUI(){
        
        mapView.addSubview(watchListButton)
        
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            watchListButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 125),
            
            watchListButton.widthAnchor.constraint(equalToConstant: 100),
            
            watchListButton.heightAnchor.constraint(equalToConstant: 25),
            
            watchListButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 250)
        ])
    }
    
        // MARK: - Button Actions
        //attach our button to a target
    private func addButtonTargets(){
        watchListButton.addTarget(self, action: #selector(onWatchListButtonTapped), for: .touchUpInside)
    }
    
    //button action event
    @objc private func onWatchListButtonTapped(){
        
        configureSheet()
    }
    
    //set up our mapview and bounds
    private func updateMapView(){
        
        view.addSubview(mapView)
        
        mapView.frame = view.bounds
    }
    
        // MARK: - Sheet Presentation
    // set up our sheet presentation
    private func configureSheet() {
        let sheetController = SheetViewController()
        sheetController.fetchedStores = fetchedStores

        let sheetNav = UINavigationController(rootViewController: sheetController)
        
        if let sheet = sheetNav.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                0.35 * context.maximumDetentValue
            }), .large()]
            
            sheet.largestUndimmedDetentIdentifier = .large
            
            sheet.prefersGrabberVisible = true
            
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        navigationController?.present(sheetNav, animated: true)
    }

}

    // MARK: - MKMapViewDelegate
extension StoreLocatorViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "storeAnnotation"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
