//
//  Product.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let thumbnail: String
    let description: String
}

struct ProductsResponse: Codable {
    let products: [Product]
}
