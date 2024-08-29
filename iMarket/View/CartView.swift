//
//  CartView.swift
//  iMarket
//
//  Created by Justin Li on 8/27/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @State private var isExpanded: Bool = false
    @State private var selectedOption: String = "Pick up"

    let options = ["Pick up", "Delivery"]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2) {
                // Dropdown under the navigation title
                HStack {
                    Menu {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                            }) {
                                Text(option)
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(selectedOption)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("from")
                        .foregroundColor(.gray)
                    
                    Text("Cupertino")
                        .underline()
                        .foregroundColor(.white)
                }
                .padding(.leading, 16)
                List(viewModel.cart) { item in
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
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        Text("$\(item.product.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 10)
                }
                .listStyle(PlainListStyle()) // Makes the list look flat
                
                // Summary Section
                VStack {
                    HStack {
                        Text("$\(viewModel.cartTotal, specifier: "%.2f") total")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(viewModel.cart.count) items")
                            .font(.subheadline)
                        
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(width: 361, height: 86)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                    if isExpanded {
                        VStack(alignment: .leading) {
                            // Optional details like taxes, discounts, etc.
                            Text("Subtotal: $\(viewModel.cartSubtotal, specifier: "%.2f")")
                            Text("Tax: $\(viewModel.tax, specifier: "%.2f")")
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)

                // Checkout Button
                Button(action: {
                    // Checkout action
                }) {
                    Text("Check out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 12, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding(.horizontal)
                }
                .padding(.bottom) // Adds space at the bottom of the screen
            }
            .navigationTitle("Cart") // Use the built-in navigation title
        }
    }
}

#Preview {
    CartView()
        .environmentObject(ProductViewModel())
}

