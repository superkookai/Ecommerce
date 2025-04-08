//
//  HomeView.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @Environment(CartManager.self) var cartManager: CartManager
    
    fileprivate var NavigationBarView: some View {
        HStack {
            Text("Ecommerce App")
                .font(.system(size: 16, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .trailing) {
            Button {
                
            } label: {
                ZStack {
                    Image(systemName: "cart.fill")
                        .tint(.black)
                    
                    if cartManager.numberOfProductsInCart > 0 {
                        ZStack {
                            Circle()
                                .foregroundStyle(.red)
                            Text("\(cartManager.numberOfProductsInCart)")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .offset(CGSize(width: 10, height: -10))
                    }
                }
            }
            .padding(.trailing)
            
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    NavigationBarView
                    
                    Image("banner")
                        .bannerImageStyle()
                    
                    HStack {
                        Text("Featured")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading)
                        
                        Spacer()
                        
                        NavigationLink {
                            ProductGridView(filter: .featured)
                        } label: {
                            Text("View All")
                                .font(.system(size: 15, weight: .bold))
                                .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.fetchProducts(filter: .featured)) { product in
                                ProductRow(product: product)
                            }
                        }
                    }
                    .padding(.leading, 5)
                    
                    HStack {
                        Text("Highly Rated")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading)
                        
                        Spacer()
                        
                        NavigationLink {
                            ProductGridView(filter: .highlyRated)
                        } label: {
                            Text("View All")
                                .font(.system(size: 15, weight: .bold))
                                .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.fetchProducts(filter: .highlyRated)) { product in
                                ProductRow(product: product)
                            }
                        }
                    }
                    .padding(.leading, 5)
                    
                    Button {
                        viewModel.showAllProducts = true
                    } label: {
                        Text("See Full Catalog")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal)
                }
            }
            .navigationDestination(isPresented: $viewModel.showAllProducts) {
                ProductGridView(filter: .all)
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(CartManager())
        .environment(FavoriteManager())
}
