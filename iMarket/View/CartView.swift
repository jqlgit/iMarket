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
            VStack(alignment: .leading, spacing: 16) {
                // Dropdown for pick up or delivery
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
                    
                    Text(selectedOption == "Pick up" ? "from" : "to")
                        .foregroundColor(.gray)
                    
                    Text("Cupertino")
                        .underline()
                        .foregroundColor(.white)
                }
                .padding(.leading, 16)

                if viewModel.cart.isEmpty {
                    Spacer()

                    VStack {
                        Image(systemName: "cart.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Text("Add items to cart")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 50)
                } else {
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
                                    .fontWeight(.regular)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            Text("$\(item.product.price, specifier: "%.2f")")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 10)
                    }
                    .listStyle(PlainListStyle())
                }
                
                // Summary Section
                VStack {
                    HStack {
                        VStack {
                            Text("$\(viewModel.cartTotal, specifier: "%.2f") total")
                                .font(.headline)
                            Text("\(viewModel.cart.count) item(s)")
                                .font(.subheadline)
                                .padding(.trailing, 22)
                        }
                        
                        Spacer()
                        
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
                            // Extra information
                            Text("Subtotal: $\(viewModel.cartSubtotal, specifier: "%.2f")")
                            Text("Tax: $\(viewModel.tax, specifier: "%.2f")")
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 100)

                // Checkout Button
                Button(action: {
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
                .padding(.bottom, 20)
            }
            .navigationTitle("Cart")
        }
    }
}

#Preview {
    CartView()
        .environmentObject(ProductViewModel())
}
