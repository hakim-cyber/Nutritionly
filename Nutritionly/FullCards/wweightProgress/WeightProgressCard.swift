//
//  WeightProgressCard.swift
//  Nutritionly
//
//  Created by aplle on 5/24/23.
//

import SwiftUI


struct WeightProgressCard: View {
    @EnvironmentObject var userStore:UserStore
    @State private var screen = UIScreen.main.bounds
    
    @State private var days = [Day]()
    var body: some View {
        ZStack{
            // weight loss
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.yellow,lineWidth:3)
            VStack{
                
                HStack{
                    Image(systemName: "chart.bar.xaxis")
                        .foregroundColor(.white)
                        .padding(9)
                        .background(Color.yellow)
                        .clipShape(Circle())
                    Text("Weight")
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
                    Spacer()
                   
                }
                
                Spacer()
             
                weightProgressChart()
            }
            .padding(10)
           
        }
        .frame(width: screen.width / 1.05,height:130)
        .onAppear(perform: loadDaysOfUser)
        
    }
    func loadDaysOfUser(){
        userStore.fetchUserUsingThisApp()
        
        days = (userStore.userForApp.first?.days ?? [Day]()).sorted{$0.order < $1.order}
    }
}

struct WeightProgressCard_Previews: PreviewProvider {
    static var previews: some View {
        WeightProgressCard()
            .environmentObject(UserStore())
    }
}
