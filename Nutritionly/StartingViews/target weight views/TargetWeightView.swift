//
//  TargetWeightView.swift
//  Nutritionly
//
//  Created by aplle on 5/27/23.
//

import SwiftUI

struct TargetWeightView: View {
    @AppStorage("targetweight") var targetweight = 0.0
 @State private var weightInt = 50
    @State private var weightDouble = 1
    
    @State private var next = false
    
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
        
        ZStack  {
            if next{
                ActivityLevelView()
                    .transition(.move(edge: .bottom))
                
            }else{
            VStack(spacing: 20){
                Text("What's your dream weight?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.thinMaterial)
                    VStack{
                        HStack{
                            Text("Target Weight")
                                .foregroundColor(colorScheme == .light ? .black : .white)
                            Spacer()
                            Text("\(targetWeightView.formatted()) kg")
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                        Divider()
                        VStack{
                            MultipleSectionWeightPicker(weightInt: $weightInt, weightDouble: $weightDouble)
                           
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                    
                }
                .frame(height:300)
                Text("Don't worry you can change it later")
                    .foregroundColor( .black)
                Spacer()
                Spacer()
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.top)
            .padding(.horizontal,20)
            .transition(.move(edge: .top))
            .safeAreaInset(edge: .bottom){
                HStack{
                    Spacer()
                    RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                        withAnimation(.easeInOut){
                            
                            targetweight = targetWeightView
                            next = true
                        }
                        
                    })
                    .padding(20)
                    .font(.title2)
                }
            }
            
        }
        }
    }
    var targetWeightView:Double{
        Double(weightInt) + Double(weightDouble) / 10
    }
}

struct TargetWeightView_Previews: PreviewProvider {
    static var previews: some View {
        TargetWeightView()
    }
}
