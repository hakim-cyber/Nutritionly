//
//  ProgressView.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import SwiftUI

struct CustomProgressView: View {
    var progress:Double
    var color:Color = Color.black
    var body: some View {
        ZStack{
            Circle()
                .stroke(.black,lineWidth: 5.0)
                .opacity(0.20)
                .overlay(alignment:.bottom){
                    Rectangle()
                        .fill(Color.black)
                        .frame(width:100,height: 100 * progress)
                        .animation(.spring(), value: progress)
                }
            
          
               
        }
        .frame(width: 100,height: 100)
        .clipShape(Circle())
        .overlay(alignment: .bottom){
            Text("\(Int(progress * 100) ,format: .percent)")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontDesign(.monospaced)
                .fontWeight(.bold)
                .padding(.bottom,25)
                .animation(.spring(), value: progress)
               
        }
    }
}

struct  CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(progress: 1)
    }
}
