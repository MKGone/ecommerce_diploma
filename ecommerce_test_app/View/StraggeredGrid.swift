//
//  StraggeredGrid.swift
//  ecommerce_test_app
//
//  Created by Mykhailo Kovalskyi on 28.05.2023.
//

import SwiftUI

struct StraggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    
    var content: (T) -> Content
    
    var list: [T]
    
    var collumns: Int
    
    var showIndicators: Bool
    var spacing: CGFloat
    
    
    init(collumns: Int,showIndicators: Bool = false, spacing: CGFloat = 10,list: [T],@ViewBuilder content: @escaping (T)->Content){
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showIndicators = showIndicators
        self.collumns = collumns
    }
    
    func setUpList()->[[T]]{
        
        var gridArray: [[T]] = Array(repeating: [], count: collumns)
        
        var currentIndex: Int = 0
        
        for object in list{
            gridArray[currentIndex].append(object)
            
            
            if currentIndex == (collumns - 1){
                currentIndex = 0
            }else{
                currentIndex += 1
            }
            
        }
        
        return gridArray
        
    }
    
    var body: some View {
        

        HStack(alignment: .top, spacing: 20){
            
            ForEach(setUpList(), id: \.self){collumnsData in
                
                LazyVStack(spacing: spacing){
                    
                    ForEach(collumnsData){object in
                        
                        content(object)
                        
                    }
                    
                }
                
            }
            
        }
        
        .padding(.vertical)
        
    }
}

struct StraggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
