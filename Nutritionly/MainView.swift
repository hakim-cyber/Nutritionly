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
            Color.backgroundColor.ignoresSafeArea()
            
            VStack(spacing:30){
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("have a good day!")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        Text("how was your day? let's tell us what did you do ")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Button{
                        
                    }label: {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(Color.openGreen)
                        .shadow(color: .black,radius: 10)
                    
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
                    Text("activities")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    
                    Spacer()
                    
                }
                Spacer()
               
               
            }
            .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NutritionData_Manager())
    }
}
