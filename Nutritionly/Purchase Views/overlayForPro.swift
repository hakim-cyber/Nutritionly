//
//  overlayForPro.swift
//  Nutritionly
//
//  Created by aplle on 6/24/23.
//

import SwiftUI
enum feutureType{
    case water, workout,steps
}

struct overlayForPro: View {
    let width:CGFloat
    let height:CGFloat
    let cornerRadius:CGFloat
    let feature:feutureType
    @EnvironmentObject var userStore:UserStore
   
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.ultraThinMaterial)
            VStack(spacing: 10){
                
                ProSymbol()
                if feature == .steps{
                    Text("Track Daily Steps 🏃‍♀️")
                        .font(.system(size: width / 15))
                        .fontWeight(.bold)
                        .lineLimit(1)
                      
                        
                      
                }else if feature == .water{
                    Text("Track Daily Water Intake 💧")
                        .font(.system(size: width / 25))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        
                }else{
                    Text("Track Your Workout🏋️")
                        .font(.system(size: width / 15))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        
                }
              
                
            }
           
        }
        .frame(width: width,height: height)
        .onTapGesture {
            withAnimation(.easeInOut){
                userStore.showPurchaseView = true
            }
        }
    }
}

struct overlayForPro_Previews: PreviewProvider {
    static var previews: some View {
        overlayForPro(width: 100, height: 100,cornerRadius: 15,feature: .steps)
            .environmentObject(UserStore())
    }
}
