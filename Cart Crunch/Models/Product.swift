//
//  Product.swift
//  Cart Crunch
//
//  Created by TaeVon Lewis on 4/12/23.
//

import UIKit

struct Product: Codable {
    let productId: String
    let description: String
    let items: [ProductItem]
}

struct ProductItem: Codable {
    let price: Price?
}

struct Price: Codable {
    let regular: Double
    let promo: Double
}

struct ProductsResponse: Codable {
    let data: [Product]
}
