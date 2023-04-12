//
//  Store.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/12/23.
//

import UIKit

struct Store: Codable {
    let locationId: String
    let name: String
    let address: Address
    let geolocation: Geolocation
}

struct Geolocation: Codable {
    let longitude: Double
    let latitude: Double
    let latLng: String
}

struct Address: Codable {
    let addressLine1: String
    let city: String
    let state: String
    let zipCode: String
    let county: String
}

struct StoresResponse: Codable {
    let data: [Store]
}
