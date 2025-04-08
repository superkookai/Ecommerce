//
//  BannerImageModifier.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation
import SwiftUI

extension Image {
    
    func bannerImageStyle() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 250)
            .clipped()
    }
}


