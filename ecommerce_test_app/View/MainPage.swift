//
//  MainPage.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 23.05.2023.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab: Tab = .Home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    @Namespace var animation
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            TabView(selection: $currentTab){
                
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
                
            }
            
            HStack(spacing:0){
                ForEach(Tab.allCases, id: \.self){tab in
                    
                    Button{
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                            Color("TextColor")
                                .opacity(0.1)
                                .cornerRadius(5)
                                .blur(radius: 5)
                                .padding(-7)
                                .opacity(currentTab == tab ? 1 : 0)
                            
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("TextColor") : Color.white)
                    }
                    
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom)
        }
        .background(Color("Black").ignoresSafeArea())
        .overlay(
            
            ZStack{
                
                //Detail page
                
                if let product = sharedData.detailProduct,sharedData.showDetailProduct{
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
                
            }
            
        )
        
    }
        
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String, CaseIterable {
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
