//
//  MyItemsViewModel.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import Foundation

class MyItemsViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []

    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(id: product.id, product: product, quantity: 1)
            cartItems.append(newItem)
        }
    }

    func removeFromCart(cartItem: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
            cartItems.remove(at: index)
        }
    }
}
