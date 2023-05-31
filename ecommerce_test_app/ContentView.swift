//
//  ContentView.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 29.04.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group{
            if log_Status{
                MainPage()
            }else {
                OnBoarding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
