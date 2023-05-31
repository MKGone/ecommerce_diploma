//
//  MoreProductsView.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 28.05.2023.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        
        VStack{
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("Black").ignoresSafeArea())
        
    }
        
        
}
    

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
