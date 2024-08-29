//
//  CartView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.cart) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        VStack(alignment: .leading) {
                            Text(item.product.title)
                                .font(.headline)
                            Text("Qty: \(item.quantity)")
                                .font(.subheadline)
                        }

                        Spacer()

                        Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle("Cart")
        }
    }
}


#Preview {
    CartView()
}
