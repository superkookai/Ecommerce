//
//  CartManager.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation
import SwiftUI

@Observable
class CartManager {
    var productsInCart: [ProductInCart] = []
    var alertAddToCart = false
    
    var numberOfProductsInCart: Int {
        productsInCart.reduce(into: 0, {$0 += $1.quantity})
    }
    
    func addToCart(product: Product) {
        if let index = self.productsInCart.firstIndex(where: {$0.id == product.id}) {
            self.productsInCart[index].quantity += 1
        } else {
            self.productsInCart.append(ProductInCart(product: product, quantity: 1))
        }
        alertAddToCart = true
    }
}
