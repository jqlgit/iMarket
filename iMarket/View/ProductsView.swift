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
                
                List(viewModel.filteredProducts) { product in
                    HStack(alignment: .top, spacing: 15) {
                        // Product Image
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 128, height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading, 24)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            // Product Title and Price
                            Text(product.title)
                                .font(.headline)
                                .lineLimit(1)
                            
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            // Product Category
                            Text(product.category.capitalized)
                                .frame(width: 60, height: 22)
                                .font(.caption)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                            
                            HStack(alignment: .center, spacing: 10) {
                                // Add to Cart Button
                                Button(action: {
                                    viewModel.addToCart(product: product)
                                    print("added to cart")
                                }) {
                                    Text("Add to Cart")
                                        .frame(width: 143, height: 24)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .cornerRadius(20)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                // Heart Button for favoriting
                                Button(action: {
                                    viewModel.toggleFavorite(product: product)
                                    print("added to favorite")
                                }) {
                                    Image(systemName: viewModel.isFavorite(product: product) ? "heart.fill" : "heart")
                                        .foregroundColor(viewModel.isFavorite(product: product) ? .white : .white)
                                        .frame(width: 36, height: 36)
                                        .background(Circle().fill(Color(red: 58/255, green: 58/255, blue: 60/255)))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.top, 10)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                .listStyle(PlainListStyle())
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "What are you looking for?")
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
