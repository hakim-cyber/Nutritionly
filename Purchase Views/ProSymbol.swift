//
//  ProSymbol.swift
//  Nutritionly
//
//  Created by aplle on 6/24/23.
//

import SwiftUI

struct ProSymbol: View {
   
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
           
            VStack{
                HStack{
                    Image(systemName: "crown.fill")
                        .foregroundColor(Color("openBlue"))
                        
                    Text("Pro")
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        .fontWeight(.black)
                   
                }
            }
            .padding(5)
            .padding(.trailing,5)
            
        
        
    }
}

struct ProSymbol_Previews: PreviewProvider {
    static var previews: some View {
        ProSymbol()
    }
}
