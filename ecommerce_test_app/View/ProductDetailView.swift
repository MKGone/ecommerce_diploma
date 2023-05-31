//
//  ProductDetailView.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 29.05.2023.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    var animation: Namespace.ID
    
    //Shared data model
    @EnvironmentObject var sharedData: SharedDataModel
    var body: some View {
        
        VStack{
            
            //Title bar and Product Image
            VStack{
                
                HStack{
                    Button{
                        //Closing View
                        
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    
                    Button{
                        
                    } label: {
                        Image("Liked2")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.white)
                            
                    }
                }
                .padding()
                
                //Product image
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
            }
            .frame(height: getRect().height / 2.7)
            
            //Product details
            ScrollView(.vertical, showsIndicators: false){
                
                //Product data
                
                VStack(alignment: .leading, spacing: 15){
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                        .foregroundColor(Color.white)
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Text("Get Apple TV+ free for year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                        .foregroundColor(Color.white)
                    
                    Text("Avalible when you purchase any new iPhone, iPad, iPod, MacBook for Apple TV, $4.99/month after free trial")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button{
                        
                    } label: {
                        //Since we need image at right
                        Label{
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("TextColor"))
                    }
                    
                    HStack{
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("TextColor"))
                        
                    }
                    .padding(.vertical, 20)
                    
                    Button{
                        
                    } label: {
                        Text("Add to cart")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
                                Color("ButtonColor")
                                    .cornerRadius(15)
                                    
                                
                            )
                        
                    }
                    
                    
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("Black")
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .background(Color("ProductBG").ignoresSafeArea())
        
        
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //Sample Product for Building Preview
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        
        MainPage()
        
    }
}
