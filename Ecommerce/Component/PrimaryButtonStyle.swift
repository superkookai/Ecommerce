//
//  PrimaryButtonStyle.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 08/04/2568.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 15,weight: .bold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(.blue.gradient)
            .clipShape(.rect(cornerRadius: 8))
    }
}
