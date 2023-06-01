//
//  CartPage.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 01.06.2023.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var showDeleteOption: Bool = false
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 10){
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack{
                        
                        HStack{
                            
                            Text("Cart")
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
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                            
                        }
                        if sharedData.cartProducts.isEmpty{
                            
                            VStack(alignment: .center){
                                
                                Group{
                                    Text("No Items added")
                                        .font(.custom(customFont, size: 25))
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                    
                                    Text("Hit the pluss button on each product page to save one")
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
                                
                                ForEach($sharedData.cartProducts){ $product in
                                    
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
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        
                        HStack{
                            
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Text("Checkout")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(Color.white)
                                .padding(.vertical,18)
                                .frame(maxWidth: .infinity)
                                .background(Color("ButtonColor"))
                                .cornerRadius(15)
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical)

                    }
                    .padding(.horizontal, 25)
                }
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("Black")
                    .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}


struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View{
    
    @Binding var product: Product
    var body: some View{
        
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
                
                HStack(spacing: 10){
                    
                    Text("Quantity")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(Color("Black"))
                            .frame(width: 20, height: 20)
                            .background(Color.white)
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(Color("Black"))
                            .frame(width: 20, height: 20)
                            .background(Color.white)
                            .cornerRadius(4)
                    }

                }
                
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
}
