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
    @State private var next = false
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
        if next{
            TargetWeightView()
                .transition(.move(edge: .bottom))
        }else{
           
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
                         
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            
                            
                            
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){
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
                .transition(.move(edge: .top))
                .safeAreaInset(edge: .bottom){
                    HStack{
                        Spacer()
                        RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                            withAnimation(.easeInOut){
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
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            
    }
}
