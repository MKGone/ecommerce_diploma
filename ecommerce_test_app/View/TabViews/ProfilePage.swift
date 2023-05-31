//
//  ProfilePage.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 29.05.2023.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15){
                        
                        Image("Profile_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("MKGone")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        HStack(alignment: .top, spacing: 15){
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: 50 Dragomanova\nLviv Rrgion\nLviv, Ukraine")
                                .foregroundColor(.white)
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        
                        Color.gray
                            .cornerRadius(12)
                        
                    )
                    .padding(.horizontal, 22)
                    .padding(.top, 40)
                    
                    CustomNavigationLink(title: "Edit Profile"){
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("White").ignoresSafeArea())
                            .foregroundColor(.red)
                    }
                    
                    CustomNavigationLink(title: "Shopping address"){
                        Text("")
                            .navigationTitle("Shopping Address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("White").ignoresSafeArea())
                            .foregroundColor(.white)
                    }
                    
                    CustomNavigationLink(title: "Order history"){
                        Text("")
                            .navigationTitle("Order history")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("White").ignoresSafeArea())
                    }

                    CustomNavigationLink(title: "Edit Profile"){
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("White").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Cards"){
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color(.white).ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Notifications"){
                        Text("")
                            .navigationTitle("Notifications")
                            .accentColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("White").ignoresSafeArea())
                    }


                    
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
                
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
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping ()->Detail)->some View{
        
        NavigationLink{
            content()
        } label: {
            HStack{
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                
            }
            .foregroundColor(.white)
            .padding()
            .background(
            Color("Gray")
                .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
        
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
