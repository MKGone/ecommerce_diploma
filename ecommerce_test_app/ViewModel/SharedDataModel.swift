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
    
}


