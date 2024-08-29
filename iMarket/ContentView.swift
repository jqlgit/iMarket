//
//  ContentView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductViewModel()

    var body: some View {
        TabView {
            ProductsView()
                .tabItem {
                    Label("Products", systemImage: "carrot.fill")
                }
                .environmentObject(viewModel)

            MyItemsView()
                .tabItem {
                    Label("My Items", systemImage: "heart")
                }
                .environmentObject(viewModel)

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(viewModel.cart.count)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
}
