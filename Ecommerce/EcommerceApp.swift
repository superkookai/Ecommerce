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
    @State private var tabManager = TabManager()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabManager.selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(1)
                
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
                    .tag(2)
                
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "heart.fill")
                    }
                    .tag(3)
            }
            .environment(favoriteManager)
            .environment(cartManager)
            .environment(tabManager)
            .preferredColorScheme(.light)
            .tint(.black)
        }
    }
}
