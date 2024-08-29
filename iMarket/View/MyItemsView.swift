//
//  MyItemsView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct MyItemsView: View {
    @StateObject var viewModel = MyItemsViewModel()

    var body: some View {
        List(viewModel.cartItems) { cartItem in
            HStack {
                Text(cartItem.product.title)
                Spacer()
                Text("Qty: \(cartItem.quantity)")
            }
        }
        .navigationTitle("My Items")
    }
}

#Preview {
    MyItemsView()
}
