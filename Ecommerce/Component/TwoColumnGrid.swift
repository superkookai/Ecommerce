//
//  TwoColumnGrid.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation
import SwiftUI

struct TwoColumnGrid<Content:View>: View {
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                content()
            }
        }
    }
}
