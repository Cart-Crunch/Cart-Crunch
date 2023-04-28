//
//  NetworkManager.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/12/23.
//

import Foundation

    // MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.kroger.com/v1"
    private let apiKey = "cartcrunch-23dd38d6955a6f01b773fce7d94cb34b4072674531177743842"
    private let apiSecret = "_CECKtY7dAaJvdi0fX5zyO4m7KE0k7oChMIxvA0U"
    private let session = URLSession(configuration: .default)
    
    private enum Endpoints {
        case oauth2Token
        case products
        case locations
        
        var urlString: String {
            switch self {
                case .oauth2Token:
                    return "/connect/oauth2/token"
                case .products:
                    return "/products"
                case .locations:
                    return "/locations"
            }
        }
        
        var url: URL? {
            return URL(string: NetworkManager.shared.baseURL + self.urlString)
        }
    }
    
        // MARK: - Fetch Access Token
        /// Fetches the access token needed for API requests.
        /// - Parameters:
        /// - completion: Completion handler that returns a Result with the access token or an Error.
    func fetchAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = Endpoints.oauth2Token.url else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(Data("\(apiKey):\(apiSecret)".utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials&scope=product.compact".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let accessToken = json?["access_token"] as? String {
                    completion(.success(accessToken))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse access token"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
        // MARK: - Fetch Products
        /// Fetches products based on the given search term.
        /// - Parameters:
        ///   - searchTerm: The term to search products by.
        ///   - completion: Completion handler that returns a Result with an array of Product instances or an Error.
    func fetchProducts(searchTerm: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        fetchAccessToken { result in
            switch result {
                case .success(let accessToken):
                    guard var urlComponents = URLComponents(string: "\(self.baseURL)/products") else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                        return
                    }
                    
                        // TODO: Remove hardcoded values and get locationId from api
                    urlComponents.queryItems = [
                        URLQueryItem(name: "filter.term", value: searchTerm),
                        URLQueryItem(name: "filter.limit", value: "25"),
                        URLQueryItem(name: "filter.start", value: "1"),
                        URLQueryItem(name: "filter.locationId", value: "09000278")
                    ]
                    
                    guard let url = urlComponents.url else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                        return
                    }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        
                        guard let data = data else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                            return
                        }
                
                        do {
                            let decoder = JSONDecoder()
                            let productsResponse = try decoder.decode(ProductsResponse.self, from: data)
                            completion(.success(productsResponse.data))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    
                    task.resume()
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
        // MARK: - Fetch Nearby Stores
        /// Fetches nearby stores based on the given latitude and longitude.
        /// - Parameters:
        ///   - latitude: The latitude to search nearby stores.
        ///   - longitude: The longitude to search nearby stores.
        ///   - completion: Completion handler that returns a Result with an array of Store instances or an Error.
    func fetchNearbyStores(latitude: Double, longitude: Double, completion: @escaping (Result<[Store], Error>) -> Void) {
        print("\(latitude), \(longitude)")
        fetchAccessToken { result in
            switch result {
                case .success(let accessToken):
                    guard var urlComponents = URLComponents(string: "\(self.baseURL)/locations") else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                        return
                    }
                    
                    urlComponents.queryItems = [
                        URLQueryItem(name: "filter.lat.near", value: "\(latitude)"),
                        URLQueryItem(name: "filter.lon.near", value: "\(longitude)"),
                        URLQueryItem(name: "filter.radiusInMiles", value: "100"),
                        URLQueryItem(name: "filter.limit", value: "5")
                    ]
                    
                    guard let url = urlComponents.url else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                        return
                    }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        
                        guard let data = data else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                            return
                        }
                        
                        do {
                            let decoder = JSONDecoder()
                            let storesResponse = try decoder.decode(StoresResponse.self, from: data)
                            completion(.success(storesResponse.data))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    
                    task.resume()
                    
                case .failure(let error):
                    completion(.failure(error))
            }
            
        }
    }

}
