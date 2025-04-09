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
    let paymentService = PaymentService()
    
    var numberOfProductsInCart: Int {
//        productsInCart.reduce(into: 0, {$0 += $1.quantity})
        productsInCart.reduce(0){ $0 + $1.quantity }
    }
    
    var displayTotalCartPrices: String {
        let total = self.productsInCart.reduce(0, {$0 + ($1.quantity * $1.product.price)})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "$0.00"
    }
    
    func addToCart(product: Product) {
        if let index = self.productsInCart.firstIndex(where: {$0.id == product.id}) {
            self.productsInCart[index].quantity += 1
        } else {
            self.productsInCart.append(ProductInCart(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(product: Product) {
        if let index = self.productsInCart.firstIndex(where: {$0.id == product.id}) {
            let currentQuantity = self.productsInCart[index].quantity
            if currentQuantity > 1 {
                let newQuantity = currentQuantity - 1
                let updatedProductInCart = ProductInCart(product: product, quantity: newQuantity)
                self.productsInCart[index] = updatedProductInCart
            } else {
                self.productsInCart.remove(at: index)
            }
        }
    }
    
    func pay() {
        guard self.productsInCart.count > 0 else { return }
        paymentService.startPayment(productsInCart: self.productsInCart) { success in
            if success {
                self.productsInCart.removeAll()
            }
        }
    }
}
