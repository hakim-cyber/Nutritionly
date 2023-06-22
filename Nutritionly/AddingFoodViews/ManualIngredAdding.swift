//
//  ManualIngredAdding.swift
//  Nutritionly
//
//  Created by aplle on 6/22/23.
//

import SwiftUI

struct ManualIngredAdding: View {
    let color:Color
    var select:([Ingredients])-> Void
    
    @State private var title = ""
    @State private var serviceSize = 0
    @State private var kcal = 0
    @State private var protein = 0
    @State private var carb = 0
    @State private var fat = 0
    
    @State private var screen = UIScreen.main.bounds.size
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            VStack(spacing: 30){
                HStack{
                    Spacer()
                    TextField("Title",text: $title)
                        .font(.system(size: 20))
                        .fontDesign(.monospaced)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                HStack{
                    ZStack{
                        // servingSize
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                        
                        VStack(alignment: .leading){
                           Text("Serving Size (g)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.11)
                                .scaledToFit()
                           
                                Picker("",selection: $kcal){
                                    ForEach(0...1000,id:\.self){
                                        Text("\($0)")
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            
                        }
                       
                        .padding(15)
                        
                        
                    }
                    .frame(width: screen.width / 2.3,height: screen.height / 5)
                    ZStack{
                        //calorie per 100 gram
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                        
                    }
                    .frame(width: screen.width / 2.3,height: screen.height / 5)
                }
               
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

struct ManualIngredAdding_Previews: PreviewProvider {
    static var previews: some View {
        ManualIngredAdding(color: Color.openGreen){_ in
            
        }
    }
}
