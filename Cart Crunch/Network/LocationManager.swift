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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed with error: \(error.localizedDescription)")
    }

        // MARK: - CLLocationManagerDelegate
        /// Handles the updated location information.
        /// - Parameters:
        ///   - manager: The location manager object.
        ///   - locations: An array of CLLocation objects containing the location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")

            fetchStores(for: location.coordinate) { [weak self] result in
                switch result {
                    case .success(let stores):
                        print("sucess")
                            // Handle success, e.g., update the UI, send a notification, etc.
                    case .failure(let error):
                        print("error")
                            // Handle failure, e.g., show an error message to the user
                }
            }
        }
    }

    
        // MARK: - Fetch Stores
        /// Fetches stores for the given coordinate.
        /// - Parameter
        /// - coordinate: A CLLocationCoordinate2D object containing the user's location.
    typealias FetchStoresCompletionHandler = (Result<[Store], Error>) -> Void
    
    func fetchStores(for coordinate: CLLocationCoordinate2D, completion: @escaping FetchStoresCompletionHandler) {
        networkManager.fetchNearbyStores(latitude: coordinate.latitude, longitude: coordinate.longitude, completion: completion)
    }

}
