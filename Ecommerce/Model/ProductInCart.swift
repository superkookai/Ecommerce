//
//  ProductInCart.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation

struct ProductInCart: Identifiable {
    let product: Product
    var quantity: Int
    
    var id: String {
        product.id
    }
}
