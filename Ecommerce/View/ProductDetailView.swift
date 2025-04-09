//
//  ProductDetailView.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    @Environment(CartManager.self) var manager: CartManager
    
    var body: some View {
        @Bindable var manager = manager
        
        ScrollView {
            VStack(alignment: .leading) {
                Image(product.image)
                    .bannerImageStyle()
                
                Group {
                    Text(product.title)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.bottom, 5)
                    
                    Text(product.description)
                        .font(.system(size: 15))
                        .padding(.bottom, 15)
                    
                    Button {
                        manager.addToCart(product: product)
                        manager.alertAddToCart = true
                    } label: {
                        Text("Add to Cart")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .alert("Add Product to Cart", isPresented: $manager.alertAddToCart) {
                Button {
                    
                } label: {
                    Text("OK")
                }
            } message: {
                Text("You have added \(product.title) to Cart")
            }

        }
    }
}

#Preview {
    ProductDetailView(product: Product.previewProduct)
        .environment(CartManager())
}
