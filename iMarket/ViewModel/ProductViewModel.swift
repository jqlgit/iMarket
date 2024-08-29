//
//  ProductViewModel.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [CartItem] = []

    func fetchProducts() {
        ProductService.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    print("Error fetching products: \(error)")
                }
            }
        }
    }

    func searchProducts(query: String) {
        ProductService.shared.searchProducts(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    print("Error searching products: \(error)")
                }
            }
        }
    }

    func addToCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(id: product.id, product: product, quantity: 1))
        }
    }
}
