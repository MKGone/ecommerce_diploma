//
//  OnBoarding.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 29.04.2023.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnBoarding: View {
    
    @State var showLoginPage: Bool = false
    var body: some View {
        
        
        
        VStack(spacing: 50){
            Image("Image1")
                .resizable()
                .scaledToFit()
                .frame(width: 350.0, height: 350.0)
            Text("Find your gadget")
                .font(.custom(customFont, size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
    
            
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .background(Color("Gray"))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("TextColor"))
            }
            .padding(.horizontal)
            .padding(.bottom)
            .offset(y: getRect().height < 750 ? 60 : 150)
        }
        
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Black")
        )
        
        .overlay(
        
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
            
        )
        
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
