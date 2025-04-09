//
//  PaymentService.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 09/04/2568.
//

import Foundation
import PassKit

class PaymentService: NSObject {
    
    func startPayment(productsInCart: [ProductInCart]) {
        //Create Payment Summary Items
        var paymentSummaryItems: [PKPaymentSummaryItem] = []
        paymentSummaryItems = productsInCart.map({
            PKPaymentSummaryItem(label: "\($0.product.title) x \($0.quantity)", amount: NSDecimalNumber(value: $0.quantity*$0.product.price), type: .final) })
        let totalPrice = productsInCart.reduce(0, {$0 + ($1.quantity*$1.product.price) })
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: totalPrice), type: .final)
        paymentSummaryItems.append(total)
        
        //Create Payment Request
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.superkookai.Ecommerce" //Need to Add Apple Pay Capability
        paymentRequest.supportedNetworks = [.visa, .masterCard]
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
    }
}
