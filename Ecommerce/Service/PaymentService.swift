//
//  PaymentService.swift
//  Ecommerce
//
//  Created by Weerawut Chaiyasomboon on 09/04/2568.
//

import Foundation
import PassKit

class PaymentService: NSObject {
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var paymentCompletionHandler: ((Bool) -> Void)?
    
    func startPayment(productsInCart: [ProductInCart], completion: @escaping (Bool)->Void) {
        paymentCompletionHandler = completion
        
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
        paymentRequest.shippingType = .delivery
        paymentRequest.requiredShippingContactFields = [.name,.postalAddress]
        paymentRequest.shippingMethods = shippingMethodCalculator()
        
        //Create Payment Controller
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { presented in
            if presented {
                print("Payment controller successfully presented")
            } else {
                print("Payment controller failed to presented")
            }
        })
    }
    
    private func shippingMethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calendar = Calendar.current
        
        if let shippingStartDate = calendar.date(byAdding: .day, value: 5, to: today),
           let shippingEndDate = calendar.date(byAdding: .day, value: 10, to: today) {
            
            let startComponents = calendar.dateComponents([.calendar,.year,.month,.day], from: shippingStartDate)
            let endComponents = calendar.dateComponents([.calendar,.year,.month,.day], from: shippingEndDate)
            
            let freeShippingDelivery = PKShippingMethod(label: "Free Delivery", amount: NSDecimalNumber(value: 0.0))
            freeShippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            freeShippingDelivery.detail = "Free Delivery"
            freeShippingDelivery.identifier = "FREEDELIVERY"
            
            return [freeShippingDelivery]
        }
        
        return []
    }
}

extension PaymentService: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let status = PKPaymentAuthorizationStatus.success
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: nil))
        
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.paymentCompletionHandler?(true)
                } else {
                    self.paymentCompletionHandler?(false)
                }
            }
        }
    }
}
