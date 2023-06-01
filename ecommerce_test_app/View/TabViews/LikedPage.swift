//
//  LikedPage.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 01.06.2023.
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack{
                    
                    HStack{
                        
                        Text("Favourites")
                            .font(.custom(customFont, size: 28).bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button{
                            withAnimation{
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.white)
                                
                                
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                        
                    }
                    if sharedData.likedProducts.isEmpty{
                        
                        VStack(alignment: .center){
                            
                            Group{
                                Text("No favourites yet")
                                    .font(.custom(customFont, size: 25))
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold)
                                
                                Text("Hit the like button on each product page to save favourite one")
                                    .font(.custom(customFont, size: 18))
                                    .foregroundColor(Color.white.opacity(0.7))
                                    .padding(.horizontal)
                                    .padding(.top,10)
                                    .multilineTextAlignment(.center)
                                
                            }
                            
                            
                        }
                    }
                    else{
                        
                        //Displaying products
                        VStack(spacing:15){
                            
                            ForEach(sharedData.likedProducts){ product in
                                
                                HStack(spacing: 0){
                                    
                                    if showDeleteOption{
                                        Button{
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(Color.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("Black")
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)-> some View{
        
        HStack(spacing: 15){
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8){
                
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                
                Text("Type: \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(Color.white.opacity(0.7))
                
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            
            Color("ProductBG")
                .cornerRadius(10)
        
        )
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
