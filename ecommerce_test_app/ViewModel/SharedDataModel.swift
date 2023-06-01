//
//  SharedDataModel.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 29.05.2023.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    //Detail product data
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    @Published var fromSearchPage: Bool = false
    @Published var likedProducts: [Product] = []
    @Published var cartProducts: [Product] = []
    
    func getTotalPrice()->String{
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "$\(total)"
    }
    
}


