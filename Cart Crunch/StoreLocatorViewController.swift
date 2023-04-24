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
    
    
    
    private let mapView : MKMapView = {
        
        let map = MKMapView()
        
        map.overrideUserInterfaceStyle = .dark
        
        return map
    }()
    
    private let manager = CLLocationManager()
    
//    private let locationSearchBar: UISearchBar = {
//
//        let searchBar = UISearchBar()
//
//        return searchBar
//
//    }()
    
    private let watchListButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Watch List", for: .normal)
        
        button.backgroundColor = .systemGray
        
        button.layer.cornerRadius = 5
        
        return button
    }()

    private let locationsTableView: UITableView = {

        let tableView = UITableView()

        tableView.backgroundColor = .systemBackground
        
        tableView.allowsSelection = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "location")
        
        tableView.rowHeight = 50

        return tableView
    }()
    
    
    //attach our button to a target
    private func addButtonTargets(){
        
        watchListButton.addTarget(self, action: #selector(onWatchListButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        navigationController?.isNavigationBarHidden = true
        
        setupUI()
        updateMapView()
        addButtonTargets()
        
        view.backgroundColor = .blue
        
        createAnnotations(locations:annotationLocations)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        manager.desiredAccuracy = kCLLocationAccuracyBest // battery
        
        manager.delegate = self
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
    }
    
    // location manager gets location of the user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    
    // will render the map to the users area
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1 , longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        
        pin.coordinate = coordinate
        
        mapView.addAnnotation(pin)
    }
    
    
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
    
    //button action event
    @objc private func onWatchListButtonTapped(){
        
        configureSheet()
    }
    
    //set up our mapview and bounds
    private func updateMapView(){
        
        view.addSubview(mapView)
        
        mapView.frame = view.bounds
        
        // TODO: Set map viewing region and scale
        // need to define coordinate
        
        
        
        // TODO: add annotation to the map view
        
        
    }
    
    // set up our sheet presentation
    private func configureSheet(){
        
        let sheetController = SheetViewController()
        
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
    
    
    //have to put our api locations into an array. below is a hard coded sample array of locations
    let annotationLocations = [
        
        ["title": "point 1", "latitude": 37.790782, "longitude":-122.408881],
        ["title": "point 2", "latitude": 37.795846, "longitude": -122.401530],
        ["title": "point 3", "latitude": 37.779024, "longitude": -122.425024]
]
         
    //create our annotations on the map
    func createAnnotations(locations: [[String : Any]]){
        
        for location in locations {
            let annotations = MKPointAnnotation()
            
            annotations.title = (location["title"] as! String)
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            
            mapView.addAnnotation(annotations)
        }
    }
    
}
