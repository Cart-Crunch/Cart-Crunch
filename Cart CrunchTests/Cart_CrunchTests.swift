//
//  Cart_CrunchTests.swift
//  Cart CrunchTests
//
//  Created by TaeVon Lewis on 4/12/23.
//

import XCTest
@testable import Cart_Crunch

    // MARK: - Cart_CrunchTests
final class Cart_CrunchTests: XCTestCase {
   
    var networkManager: NetworkManager!
    
        // MARK: - Setup and Teardown
    override func setUpWithError() throws {
            // Initialize the NetworkManager before each test
        networkManager = NetworkManager()
    }
    
    override func tearDownWithError() throws {
            // Deinitialize the NetworkManager after each test
        networkManager = nil
    }
    
        // MARK: - Test Fetch Products
        /// Tests fetching products from the Kroger API.
    func testFetchProducts() throws {
        let expectation = XCTestExpectation(description: "Fetch products from Kroger API")
        
        networkManager.fetchProducts(searchTerm: "milk") { result in
            switch result {
                case .success(let products):
                    XCTAssertFalse(products.isEmpty, "No products found")
                case .failure(let error):
                    XCTFail("Error fetching products: \(error)")
            }
            expectation.fulfill()
        }
        
            // Wait for the expectation to be fulfilled, or time out after 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }
    
        // MARK: - Test Fetch Nearby Stores
        /// Tests fetching nearby stores from the Kroger API.
    func testFetchNearbyStores() throws {
        let latitude = 40.2268282
        let longitude = -74.7720528
        
        let expectation = XCTestExpectation(description: "Fetch nearby stores from Kroger API")
        
        networkManager.fetchNearbyStores(latitude: latitude, longitude: longitude) { result in
            switch result {
                case .success(let stores):
                    XCTAssertFalse(stores.isEmpty, "No stores found")
                case .failure(let error):
                    XCTFail("Error fetching nearby stores: \(error)")
            }
            expectation.fulfill()
        }
        
            // Wait for the expectation to be fulfilled, or time out after 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }

}
