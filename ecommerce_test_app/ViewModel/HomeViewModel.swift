//
//  HomeViewModel.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 23.05.2023.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .Wearable
    
    
    
    @Published var products: [Product] = [
        Product(type: .Phones, title: "iPhone 14 Pro Max", subtitle: "128 GB Deep Purple", price: "$999", productImage: "iPhone14ProMax"),
        Product(type: .Phones, title: "iPhone 14", subtitle: "128 GB Black", price: "$599", productImage: "iPhone14"),
        Product(type: .Phones, title: "iPhone 14 Pro Max", subtitle: "128 GB Deep Purple", price: "$999", productImage: "iPhone14ProMax"),
        Product(type: .Phones, title: "iPhone 14", subtitle: "128 GB Black", price: "$599", productImage: "iPhone14"),
        Product(type: .Phones, title: "iPhone 13 Pro Max", subtitle: "128 GB Green", price: "$899", productImage: "iPhone13ProMax"),
        Product(type: .Phones, title: "iPhone 14", subtitle: "128 GB Black", price: "$599", productImage: "iPhone14"),
        Product(type: .Tablets, title: "iPad 2020", subtitle: "128 GB Blue", price: "$399", productImage: "iPad2020"),
        Product(type: .Tablets, title: "iPad Air", subtitle: "64 GB Space Gray", price: "$599", productImage: "iPadAir"),
        Product(type: .Tablets, title: "iPad Pro 12,9", subtitle: "256 GB Silver", price: "$1199", productImage: "iPadPro12.9"),
        Product(type: .Laptops, title: "MakBook Air", subtitle: "256 GB Black", price: "$1299", productImage: "MacBookAir"),
        Product(type: .Laptops, title: "MakBook Pro 13", subtitle: "256 GB Space Gray", price: "$1599", productImage: "MacBookPro13"),
        Product(type: .Laptops, title: "MakBook Pro 14 M2 Pro", subtitle: "512 GB Space Gray", price: "$1999", productImage: "MacBookPro14"),
        Product(type: .Laptops, title: "MakBook Pro 16 M2 Max", subtitle: "1TB Silver", price: "$2299", productImage: "MacBookPro16"),
        Product(type: .Wearable, title: "Apple Watch 6", subtitle: "41 mm Black", price: "$299", productImage: "AppleWatch6"),
        Product(type: .Wearable, title: "Apple Watch 8", subtitle: "45mm Black", price: "$399", productImage: "AppleWatch8"),
        Product(type: .Wearable, title: "Apple Watch SE", subtitle: "40mm White", price: "$259", productImage: "AppleWatchSE"),
        Product(type: .Wearable, title: "Apple Watch Ultra", subtitle: "49mm Orange", price: "$599", productImage: "AppleWatchUltra"),
        
    ]
    
    @Published var filteredProducts: [Product] = []
    
    @Published var showMoreProductsOnType: Bool = false
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            
                .lazy
                .filter{product in
                    
                    return product.type == self.productType
                    
                }
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            
                .lazy
                .filter{product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                    
                }
                
            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
    
}

