//
//  LocationManager.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/12/23.
//

import CoreLocation

    // MARK: - LocationManager
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private let networkManager: NetworkManager
    
        // MARK: - Initializer
        /// Initializes a new LocationManager instance.
        /// - Parameters
        /// - networkManager: A NetworkManager instance to fetch nearby stores.
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
        // MARK: - Request User Location
        /// Requests the user's location and starts updating location.
    func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
        // MARK: - CLLocationManagerDelegate
        /// Handles the updated location information.
        /// - Parameters:
        ///   - manager: The location manager object.
        ///   - locations: An array of CLLocation objects containing the location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            fetchStores(for: location.coordinate)
        }
    }
    
        // MARK: - Fetch Stores
        /// Fetches stores for the given coordinate.
        /// - Parameter
        /// - coordinate: A CLLocationCoordinate2D object containing the user's location.
    func fetchStores(for coordinate: CLLocationCoordinate2D) {
        networkManager.fetchNearbyStores(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
            switch result {
                case .success(let stores):
                    print("Fetched stores:", stores)
                        // Handle the fetched stores, e.g., update the UI or store them in a property
                case .failure(let error):
                    print("Error fetching stores:", error)
                        // Handle the error, e.g., show an error message
            }
        }
    }
}

