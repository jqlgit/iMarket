//
//  ProductViewModel.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var cart: [CartItem] = []
    @Published var favorites: [Product] = []
    
    init() {
            print("ProductViewModel initialized")
    }
    
    var cartSubtotal: Double {
        return cart.reduce(0) { total, cartItem in
            total + cartItem.product.price
        }
    }

    // Calculate the tax based on the subtotal
    var tax: Double {
        return cartSubtotal * 0.08 // 8% sales tax
    }

    // Calculate the total including tax
    var cartTotal: Double {
        return cartSubtotal + tax
    }
    
    func fetchProducts() {
        ProductService.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.filteredProducts = products // Initialize filteredProducts with all products
                case .failure(let error):
                    print("Error fetching products: \(error)")
                }
            }
        }
    }
    
    func searchProducts(query: String) {
        if query.isEmpty {
            filteredProducts = products // Show all products if the query is empty
        } else {
            filteredProducts = products.filter { product in
                product.title.localizedCaseInsensitiveContains(query) ||
                product.category.localizedCaseInsensitiveContains(query)
            }
        }
    }

    func toggleFavorite(product: Product) {
           if let index = favorites.firstIndex(where: { $0.id == product.id }) {
               favorites.remove(at: index)
           } else {
               favorites.append(product)
           }
       }

   func addToCart(product: Product) {
       if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
           cart[index].quantity += 1
       } else {
           cart.append(CartItem(id: product.id, product: product, quantity: 1))
       }
   }

   func isFavorite(product: Product) -> Bool {
       return favorites.contains(where: { $0.id == product.id })
   }

   func isInCart(product: Product) -> Bool {
       return cart.contains(where: { $0.product.id == product.id })
   }
}
