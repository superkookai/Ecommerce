//
//  ProductGridViewModel.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation

@Observable
class ProductGridViewModel {
    let filter: ProductFilter
    
    init(filter: ProductFilter) {
        self.filter = filter
    }
    
    var products: [Product] {
        switch filter {
        case .all:
            ProductsClient.fetchProducts()
        case .featured:
            ProductsClient.fetchProducts().filter({ $0.isFeatured })
        case .highlyRated:
            ProductsClient.fetchProducts().filter({ $0.rating > 4 })
        }
    }
}
