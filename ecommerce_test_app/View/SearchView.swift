//
//  SearchView.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 28.05.2023.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel
    @FocusState var startTF: Bool
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack(spacing: 15){
                
                Button{
                    
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
//                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.white.opacity(0.7))
                }
                
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    TextField("Search", text: $homeData.searchText)
                        .foregroundColor(Color.white)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)

                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("TextColor"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
                
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    
                    VStack(spacing: 10){
                        
                        Text("Item not found")
                            .font(.custom(customFont, size: 22).bold())
                            .foregroundColor(.white)
                        
                        Text("Try a more generatic search term or try looking for alternative products")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                    }
                    .padding()
                    
                }
                else{
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack(spacing: 0){
                            
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                                .foregroundColor(.white)
                            
                            StraggeredGrid(collumns: 2,spacing: 15, list: products){product in
                                
                                ProductCartView(product: product)
                                
                            }
                        }
                        
                    
                    }
                }
                
            }
            else{
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("Black")
            .ignoresSafeArea()
        )
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                
                startTF = true
                
            }
        }
        
    }
    @ViewBuilder
    func ProductCartView(product: Product)-> some View{
        
        VStack(spacing: 10){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
                .foregroundColor(.white)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.white)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
                .padding(.top, 5)
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color("ProductBG")
                .cornerRadius(25)
        )
        .padding(.top,50)
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
//                sharedData.showDetailProduct = true
            }
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
