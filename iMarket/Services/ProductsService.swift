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
                // Decode only the 'products' part of the response
                let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                completion(.success(productsResponse.products))
            } catch {
                print("Error during JSON decoding: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}


extension ProductService {
    func searchProducts(query: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let urlString = "https://dummyjson.com/products/search?q=\(query)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let productsResponse = try JSONDecoder().decode([String: [Product]].self, from: data)
                if let products = productsResponse["products"] {
                    completion(.success(products))
                } else {
                    completion(.failure(NSError(domain: "Parsing Error", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
