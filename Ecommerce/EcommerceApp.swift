//
//  EcommerceApp.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import SwiftUI

@main
struct EcommerceApp: App {
    @State private var favoriteManager = FavoriteManager()
    @State private var cartManager = CartManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
                
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "heart.fill")
                    }
            }
            .environment(favoriteManager)
            .environment(cartManager)
            .preferredColorScheme(.light)
            .tint(.black)
        }
    }
}
