//
//  ProductsView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                HStack(alignment: .top, spacing: 15) {
                    // Product Image
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        // Product Title and Price
                        Text(product.title)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        // Product Category
                        Text(product.category.capitalized)
                            .font(.caption)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                        
                        // Add to Cart Button
                        Button(action: {
                            viewModel.addToCart(product: product)
                        }) {
                            Text("Add to Cart")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                    
                    // Heart Button
                    Button(action: {
                        // Handle favorite action
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                }
                .padding(.vertical, 10)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    viewModel.fetchProducts()
                } else {
                    viewModel.searchProducts(query: searchText)
                }
            }
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductsView()
}
