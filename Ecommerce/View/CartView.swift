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
        }
    }
}

#Preview {
    CartView()
        .environment(CartManager())
}

struct CartProductRow: View {
    var productInCart: ProductInCart
    
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
                } onDecrement: {
                    //Decrement
                }
            }
        }
    }
}

#Preview("CartProductRow") {
    CartProductRow(productInCart: ProductInCart(product: Product.previewProduct, quantity: 2))
}
