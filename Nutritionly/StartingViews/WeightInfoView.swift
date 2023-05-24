//
//  WeightInfoView.swift
//  Nutritionly
//
//  Created by aplle on 5/24/23.
//

import SwiftUI

struct WeightInfoView: View {
    @AppStorage("weightOfToday") var weightOfToday = 0.0
    @State private var weight = 0.0
    @State private var screen = UIScreen.main.bounds
    @State private var offset = CGSize.zero
    @FocusState private var amountIsFocused: Bool
    var close:(Double)->Void
    var body: some View {
        ZStack{
            // weight
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(.white)
                .frame(width: screen.width/1.2,height: 220)
                .padding(.horizontal,10)
                .shadow(color: .black,radius: 10)
            
            VStack(spacing: 0){
                HStack{
                    Spacer()
                    Text("Today's Weight")
                        .font(.title2)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                    Spacer()
                   
                        
                }
                Spacer()
                HStack{
                    TextField("", value: $weight,format:.number)
                        .padding()
                        .background(Color.backgroundColor)
                        .focused($amountIsFocused)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color:.gray,radius: 5)
                        
                        .labelsHidden()
                        .keyboardType(.decimalPad)
                        .scrollDismissesKeyboard(.immediately)
                  
                }
                .padding()
                Spacer()
               
            }
            .padding()
        }
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .frame(width: screen.width/1.2,height: 200)
        .gesture(
                   DragGesture()
                       .onChanged { gesture in
                           offset = gesture.translation
                          
                       }
                       .onEnded { _ in
                           if abs(offset.width) > 100 {
                              
                              
                                   withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)) {
                                       amountIsFocused = true
                                       if weight > 0.0{
                                           close(weight)
                                       }else{
                                           offset = CGSize.zero
                                       }
                                   }
                           
                               
                           } else {
                               offset = .zero
                           }
                       }
               )
     
    }
}

struct WeightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WeightInfoView(){_ in}
    }
}





