//
//  ProductsView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !searchText.isEmpty {
                    Text("\(viewModel.filteredProducts.count) results for '\(searchText)'")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
                
                List(viewModel.filteredProducts) { product in // Use filteredProducts
                    HStack(alignment: .top, spacing: 15) {
                        // Product Image
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 70, height: 70)
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
                        }
                        
                        Spacer()

                        VStack {
                            // Add to Cart Button
                            Button(action: {
                                viewModel.addToCart(product: product)
                                print("added to cart")
                            }) {
                                Text("Add to Cart")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle()) // Ensure only the button responds to taps
                            
                            // Heart Button for favoriting
                            Button(action: {
                                viewModel.toggleFavorite(product: product)
                                print("added to favorite")
                            }) {
                                Image(systemName: viewModel.isFavorite(product: product) ? "heart.fill" : "heart")
                                        .foregroundColor(viewModel.isFavorite(product: product) ? .white : .white)
                                        .frame(width: 36, height: 36)
                                        .background(Circle().fill(Color.gray))
                            }
                            .buttonStyle(PlainButtonStyle()) // Ensure only the button responds to taps
                        }
                        .padding(.top, 10)
                    }
                    .padding(.vertical, 10)
                    .contentShape(Rectangle()) // Optional: makes entire row tappable without affecting buttons
                }
                .listStyle(PlainListStyle()) // Optional: for a more compact list style
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "What are you looking for?")
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    viewModel.fetchProducts() // Reset to all products when search text is cleared
                } else {
                    viewModel.searchProducts(query: searchText) // Filter based on search text
                }
            }
            .onAppear {
                viewModel.fetchProducts() // Initial fetch of products
            }
        }
    }
}

