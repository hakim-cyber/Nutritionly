//
//  RoundedButtton.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI

struct RoundedButtonView: View {
    var text: String
    var textColor: Color
    var backgroundColor: Color
    var action: () -> Void
    var image:String?
    
    var body: some View {
        Button(action: action) {
            ZStack{
                if image == nil{
                    Text(text)
                        .foregroundColor(textColor)
                        .padding(.vertical,20)
                        .padding(.horizontal,18)
                        .background(backgroundColor)
                        .cornerRadius(30)
                }else{
                    Image(systemName: image!)
                        .foregroundColor(textColor)
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(30)
                }
                
            }
        }
        
    }
}

