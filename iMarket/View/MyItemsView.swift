//
//  MyItemsView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct MyItemsView: View {
    @EnvironmentObject var viewModel: ProductViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favorites.isEmpty {
                    emptyStateView
                } else {
                    favoritesListView
                }
            }
            .navigationTitle("My Items") // Ensure this is applied directly in the NavigationView
        }
        .onAppear {
            print("Favorites in MyItemsView: \(viewModel.favorites.map { $0.title })")
        }
    }

    // View for the empty state
    private var emptyStateView: some View {
        VStack {
            Image(systemName: "heart.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding(.bottom, 20)

            Text("Add your favorites!")
                .font(.headline)
                .padding(.bottom, 5)

            Text("Start adding items to your favorites to see them here.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }

    // View for the favorites list
    private var favoritesListView: some View {
        List(viewModel.favorites) { product in
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
                    
                    // Add to Cart and Heart Buttons
                    HStack {
                        Button(action: {
                            viewModel.addToCart(product: product)
                        }) {
                            Text("Add to Cart")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .frame(minWidth: 173)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                        
                        Spacer() // Push the heart button to the right
                        
                        // Heart Button for unfavoriting
                        Button(action: {
                            viewModel.toggleFavorite(product: product)
                        }) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(viewModel.isFavorite(product: product) ? .white : .white)
                                .frame(width: 36, height: 36)
                                .background(Circle().fill(Color.gray))
                        }
                    }
                }
                
                Spacer() // Push content to the left
            }
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    MyItemsView()
        .environmentObject(ProductViewModel())
}
