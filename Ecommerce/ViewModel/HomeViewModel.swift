//
//  HomeViewModel.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation
import SwiftUI

@Observable
class HomeViewModel {

    var showAllProducts = false
    
    func fetchProducts(filter: ProductFilter) -> [Product] {
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
