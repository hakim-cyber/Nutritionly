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
                    Circle()
                        .trim(from: 0,to: progress == 1.0 ? progress: progress * 0.9)
                        .fill(Color.blue.opacity(0.7))
                        .rotationEffect(.degrees(-90))
                      
                        
                }
                .animation(.interactiveSpring(response: 0.8,dampingFraction: 0.8).speed(0.5), value: progress)
            
          
               
        }
        .frame(width: 100,height: 100)
        .clipShape(Circle())
        .overlay(alignment: .bottom){
            Text("\(max(0,progress * 100) ,format: .number)%")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontDesign(.monospaced)
                .fontWeight(.bold)
                .padding(.bottom,25)
               
               
               
        }
        
    }
}

struct  CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(progress: 1)
    }
}
