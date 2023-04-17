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
    let images: [Image]
    let timestamp: Date?
    
    /// Fun Fact:
    ///    adding an initializer allows us to omit the props in our parameter so it doesn't yell at us for missing a property
    
    init(productId: String, description: String, items: [ProductItem], images: [Image], timestamp: Date?) {
        self.productId = productId
        self.description = description
        self.items = items
        self.images = images
        self.timestamp = timestamp
    }
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

struct Image: Codable {
    let sizes: [ImageMetaData]
}

struct ImageMetaData: Codable {
    let size: String?
    let url: String?
}

extension Product {
    static func getMockProductArray() -> [Product] {
        let product = Product(
            productId: "0001111041600",
            description: "Kroger 2% Reduced Fat Milk",
            items: [
                ProductItem(
                    price: Price(
                        regular: 1.49,
                        promo: 0
                    )
                )
            ],
            images: [
                Image(
                    sizes: [
                        ImageMetaData(
                            size: "xlarge",
                            url: "https://www-test.kroger.com/product/images/xlarge/front/0001111041600"
                        ),
                        ImageMetaData(
                            size: "small",
                            url: "https://www-test.kroger.com/product/images/small/front/0001111041600"
                        ),
                        ImageMetaData(
                            size: "large",
                            url: "https://www-test.kroger.com/product/images/large/front/0001111041600"
                        ),
                        ImageMetaData(
                            size: "medium",
                            url: "https://www-test.kroger.com/product/images/medium/front/0001111041600"
                        ),
                        ImageMetaData(
                            size: "thumbnail",
                            url: "https://www-test.kroger.com/product/images/thumbnail/front/0001111041600"
                        )
                    ]
                )
            ], timestamp: Date()
        )
        return Array(repeating: product, count: 10)
    }
}
