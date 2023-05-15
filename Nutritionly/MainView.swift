//
//  MainView.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataManager: NutritionData_Manager
    @State var screen = UIScreen.main.bounds
    
    
    var body: some View {
        ZStack{
            Color.clear.ignoresSafeArea()
            
            VStack(spacing:25){
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("have a good day!")
                            .foregroundColor(.black)
                            .font(.system(size: 23))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        Text("how was your day? let's tell us what did you do ")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                    Button{
                        
                    }label: {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.black)
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(Color.openGreen)
                        
                    
                        HStack{
                            VStack(alignment: .leading, spacing: 15){
                                Text("today")
                                    .font(.system(size: 40))
                                    .fontDesign(.monospaced)
                                    .fontWeight(.heavy)
                                HStack{
                                    Text("\(dataManager.caloriesTaken)/\(dataManager.caloriesNeed)")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("kcal")
                                        .foregroundColor(.secondary)
                                }
                                HStack{
                                    
                                    Text("p")
                                        .foregroundColor(.secondary)
                                    Text("\(dataManager.proteinTaken)g")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("c")
                                        .foregroundColor(.secondary)
                                    Text("\(dataManager.carbohydratesTaken)g")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("f")
                                        .foregroundColor(.secondary)
                                    Text("\(dataManager.fatsTaken)g")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                
                            }
                           
                            Spacer()
                            CustomProgressView(progress: dataManager.progressCalories)
                        }
                      .padding(30)
                }
                 .frame(width: screen.width / 1.1,height:200 )
                
                HStack{
                    Text("activity")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    
                    Spacer()
                    Button{
                        // additional
                    }label:{
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.horizontal, 10)
                HStack{
                    ZStack{
                        // walking hours
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.openGreen.opacity(0.1))
                            
                        
                        VStack{
                        
                            HStack{
                                Image(systemName: "figure.walk")
                                    .padding(9)
                                    .background(Color.openGreen)
                                    .clipShape(Circle())
                                    Text("\(dataManager.steps) ")
                                        .fontDesign(.default)
                                        .fontWeight(.bold)
                                Spacer()
                                  
                            }
                            
                            Spacer()
                        }
                        .padding(10)
                        
                    }
                    .frame(width: screen.width / 2.1,height:160 )
                    ZStack{
                        // workouts hour
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.red.opacity(0.1))
                            
                        VStack{
                        
                            HStack{
                                Image(systemName: "dumbbell")
                                    .padding(9)
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    Text("\(dataManager.minuteToHourText()) ")
                                        .fontDesign(.default)
                                        .fontWeight(.bold)
                                Spacer()
                                  
                            }
                            
                            Spacer()
                        }
                        .padding(10)
                        
                    }
                    .frame(width: screen.width / 2.1,height:160 )
                }
                ZStack{
                    // weight loss
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.yellow.opacity(0.1))
                    VStack{
                                           
                                               HStack{
                                                   Image(systemName: "chart.bar.xaxis")
                                                       .padding(9)
                                                       .background(Color.yellow)
                                                       .clipShape(Circle())
                                                       
                                                   Spacer()
                                                     
                                               }
                                               
                                               Spacer()
                                           }
                                           .padding(10)
                }
                .frame(width: screen.width / 1.05,height:130 )
                
                
                Button{
                    // add food
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.black)
                         
                        Text("add food")
                            .font(.system(size: 20))
                            .fontDesign(.monospaced)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: screen.width / 1.08,height: 60)
                }
               
            }
            .padding(.top)
            .padding(.horizontal)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NutritionData_Manager())
    }
}
