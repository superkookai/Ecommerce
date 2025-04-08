//
//  FavoriteView.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(FavoriteManager.self) var manager: FavoriteManager
    
    fileprivate func FavoriteProductRow(product: Product) -> some View {
        HStack {
            Image(product.image)
                .squareImageStyle()
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.bottom,1)
                
                Text(product.description)
                    .lineLimit(2)
                    .font(.system(size: 15))
            }
            
            Spacer()
            
            Button {
                manager.products.removeAll(where: {$0.id == product.id})
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }

        }
    }
    
    var body: some View {
        VStack {
            List(manager.products) { product in
                FavoriteProductRow(product: product)
            }
            .listStyle(.plain)
        }
        .overlay {
            if manager.products.isEmpty {
                ContentUnavailableView("Nothing to see here", systemImage: "list.dash.header.rectangle")
            }
        }
    }
}

#Preview {
    FavoriteView()
        .environment(FavoriteManager())
}
