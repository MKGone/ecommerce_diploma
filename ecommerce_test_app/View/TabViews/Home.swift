//
//  Home.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 23.05.2023.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(spacing: 15){
                
                ZStack{
                    if homeData.searchActivated{
                        SearchBar()
                    }else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        homeData.searchActivated = true
                    }
                }
                
                Text("Order online\ncollect in store")
                    .foregroundColor(.white)
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15){
                        ForEach(ProductType.allCases, id: \.self){type in
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }.padding(.top, 28)
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing: 25){
                        ForEach(homeData.filteredProducts ){product in
                            
                            ProductCartView(product: product)
                            
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 30)
                
                Button{
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See more")
                    }.font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("TextColor"))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
                
                
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Black"))
        .onChange(of: homeData.productType){newValue in
            homeData.filterProductByType()
            
        }
        
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
        
        .overlay{
            
            ZStack{

                if homeData.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }

            }
            
        }
    }
    
    @ViewBuilder
    func SearchBar()-> some View{
        
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.white)
            
            TextField("Search", text: .constant("Search"))
                .disabled(true)
                .foregroundColor(Color.white)

        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductCartView(product: Product)-> some View{
        
        VStack(spacing: 10){
            
            ZStack{
                
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
                
            }.frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
    
            
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
        
        .onTapGesture{
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
        
    }
    
    
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)-> some View{
        Button{
            
            withAnimation{
                homeData.productType = type
            }
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("TextColor") : Color.white)
                .padding(.bottom, 10)
                .overlay(
                    
                    ZStack{
                        if homeData.productType == type{
                            Capsule()
                                .fill(Color("TextColor"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }else{
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                        ,alignment: .bottom
                    
                )
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

