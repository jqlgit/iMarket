//
//  ProductsService.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import Foundation

class ProductService {
    static let shared = ProductService()

    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                completion(.success(productsResponse.products))
            } catch {
                print("Error during JSON decoding: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
