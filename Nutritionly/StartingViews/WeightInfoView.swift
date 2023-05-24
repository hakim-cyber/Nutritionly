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
                    Text("Weight")
                        .font(.title)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                    Spacer()
                   
                        
                }
                Spacer()
                TextField("", value: $weight,format:.number)
                    .padding()
                    .background(Color.backgroundColor)
                    .focused($amountIsFocused)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color:.gray,radius: 5)
                    .padding()
                    .labelsHidden()
                    .keyboardType(.decimalPad)
                    .scrollDismissesKeyboard(.immediately)
                Spacer()
               
            }
            .padding()
        }
        .frame(width: screen.width/1.2,height: 200)
        .toolbar {
                       ToolbarItemGroup(placement: .keyboard) {
                          
                               Spacer()
                            
                                   Button("Done") {
                                       amountIsFocused = false
                                    close(weight)
                                   }
                               
                           }
                           
                       
                   }
    }
}

struct WeightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WeightInfoView(){_ in}
    }
}





