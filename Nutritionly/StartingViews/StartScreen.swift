//
//  StartScreen.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI

struct StartScreen: View {
    @State private var buttonIsPressed = false
  
    @Namespace var namespace
   
    var body: some View {
        ZStack{
            BackGround(namespace: namespace)
            if !buttonIsPressed{
                content
            }else{
                
                LoginScreen( namespace: namespace)
                    .transition(.move(edge: .bottom))
                    
                
                
                
                
            }
        }
      
    }
    var content:some View{
        
            ZStack{
              
                    
                VStack(alignment: .center){
                    Spacer()
                    Text("start")
                    Text("your new")
                    Text("day with")
                    Text("us :)")
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .foregroundColor(.black)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                
                
                
                
            }
            .safeAreaInset(edge: .bottom){
                HStack{
                    Spacer()
                    RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)) {
                            buttonIsPressed.toggle()
                        }
                      
                        
                    })
                        .padding(20)
                        .font(.title2)
                }
            }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .environmentObject(NutritionData_Manager())
            .environmentObject(UserStore())
    }
}

