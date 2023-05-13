//
//  StartScreen.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI

struct StartScreen: View {
    @State private var buttonIsPressed = false
    var body: some View {
        if !buttonIsPressed{
            ZStack{
                BackGround()
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
                .font(.system(size: 50))
                .fontWeight(.heavy)
                
                
                
                
            }
            .safeAreaInset(edge: .bottom){
                HStack{
                    Spacer()
                    RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                        withAnimation(.spring()) {
                            buttonIsPressed = true
                        }
                      
                        
                    })
                        .padding(20)
                        .font(.title2)
                }
            }
        }else{
            LoginScreen()
                
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}

