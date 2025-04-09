//
//  CartView.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import SwiftUI

struct CartView: View {
    @Environment(CartManager.self) var manager: CartManager
    
    var body: some View {
        VStack {
            List {
                ForEach(manager.productsInCart) { productInCart in
                    CartProductRow(productInCart: productInCart)
                }
            }
            .listStyle(.plain)
            
            VStack {
                Divider()
                
                HStack {
                    Text("Total: \(manager.numberOfProductsInCart) items")
                        .font(.system(size: 16))
                    
                    Spacer()
                    
                    Text(manager.displayTotalCartPrices)
                        .font(.system(size: 16, weight: .bold))
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                .padding(.top, 10)
                
                PaymentButton(action: {
                    manager.pay()
                })
                .frame(height: 40)
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    CartView()
        .environment(CartManager())
}

struct CartProductRow: View {
    var productInCart: ProductInCart
    @Environment(CartManager.self) var manager: CartManager
    
    var body: some View {
        HStack {
            Image(productInCart.product.image)
                .squareImageStyle()
            
            VStack(alignment: .leading) {
                Text(productInCart.product.title)
                    .font(.system(size: 15))
                    .padding(.bottom, 1)
                
                Text(productInCart.product.displayPrice)
                    .font(.system(size: 15))
                
                Stepper("Quantity \(productInCart.quantity)") {
                    //Increment
                    manager.addToCart(product: productInCart.product)
                } onDecrement: {
                    //Decrement
                    manager.removeFromCart(product: productInCart.product)
                }
            }
        }
    }
}

#Preview("CartProductRow") {
    CartProductRow(productInCart: ProductInCart(product: Product.previewProduct, quantity: 2))
        .environment(CartManager())
}
