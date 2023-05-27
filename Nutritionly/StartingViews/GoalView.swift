//
//  GoalView.swift
//  Nutritionly
//
//  Created by aplle on 5/27/23.
//

import SwiftUI

struct GoalView: View {
   @AppStorage("goal") var selectedGoal = "InShape"
    let goals = ["Lose","InShape","Gain"]
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                Text("What you would like to achive ?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                ForEach(goals,id:\.self){goal in
                    ZStack{
                       
                  
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.ultraThinMaterial)
                            .frame(height: 78)
                          
                            .overlay(alignment:.trailing){
                                HStack{
                                    Image(goal.lowercased())
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110)
                                        .mask(RoundedRectangle(cornerRadius: 15)
                                            .fill(.ultraThinMaterial)
                                            .frame(height: 78))
                                        .edgesIgnoringSafeArea(.all)
                                }
                            }
                            .clipped(antialiased:false)
                            .shadow(color:selectedGoal == goal ? .green : .white, radius: 10)
                            
                           
                        VStack{
                            HStack{
                                if goal == "Lose"{
                                    Text("Lose weight")
                                    .padding(.horizontal,10)
                                    .padding()
                                    Spacer()
                                    
                                }
                                if goal == "Gain"{
                                    Text("Gain weight")
                                    .padding(.horizontal,10)
                                    .padding()
                                    Spacer()
                                }
                                if goal == "InShape"{
                                    Text("Stay In shape")
                                    .padding(.horizontal,10)
                                    .padding()
                                    Spacer()
                                }
                                
                            }
                        }
                      
                        
                       
                        
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                            selectedGoal = goal
                        }
                    }
                  
                }
                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.top)
            .padding(.horizontal)
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            
    }
}
