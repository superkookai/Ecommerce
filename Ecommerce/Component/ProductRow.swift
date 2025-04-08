//
//  ProductRow.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    @Environment(FavoriteManager.self) var manager: FavoriteManager
    
    var isFavorite: Bool {
        manager.products.contains(product)
    }
    
    var body: some View {
        NavigationLink {
            ProductDetailView(product: product)
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 8, bottomLeading: 0, bottomTrailing: 0, topTrailing: 8)))
                Group {
                    Text(product.title)
                        .font(.system(size: 15, weight: .semibold))
                        .lineLimit(1)
                    
                    Text(product.displayPrice)
                        .font(.system(size: 15))
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.yellow)
                        
                        Text(product.displayRating)
                            .font(.system(size: 14))
                    }
                }
                .padding(.horizontal, 5)
                
                Spacer()
            }
            .frame(width: 150, height: 270)
            .overlay(alignment: .topTrailing, content: {
                Button {
                    if isFavorite {
                        manager.products.removeAll(where: {$0.id == product.id})
                    } else {
                        manager.products.append(product)
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(.red)
                }
                .padding(8)
            })
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(uiColor: .lightGray).opacity(0.4), lineWidth: 2)
            }
            .tint(.black)
        }
    }
}

#Preview {
    NavigationStack {
        ProductRow(product: Product.previewProduct)
            .environment(FavoriteManager())
    }
}
