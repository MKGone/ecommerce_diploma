//
//  LoginPageModel.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 21.05.2023.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    
    //Login
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    //Register
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    //Login call
    
    @AppStorage("log_Status") var log_Status: Bool = false
    
    func Login(){
        
        
        print(email, password)
        
//        guard let url = URL(string: "http://127.0.0.1:8000/auth/jwt/create") else{
//            print("error")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
        
        withAnimation{
            log_Status = true
        }
        
        
        
    }
    
    func Register(){
        withAnimation{
            log_Status = true
        }
    }
    
    func ForgotPassword(){
    }
}

