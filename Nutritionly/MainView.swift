//
//  MainView.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import SwiftUI
import NotificationCenter
import Firebase
import FirebaseFirestoreSwift


struct MainView: View {
    @EnvironmentObject var dataManager: NutritionData_Manager
    @EnvironmentObject var userStore: UserStore
    @State var screen = UIScreen.main.bounds
    @State private var showAddView = false
    @State private var animateProgress = false
    
@Namespace var namespace
    
    var body: some View {
       
            ZStack{
                Color.white.ignoresSafeArea()
                
                if !showAddView{
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
                                    Text("\(dataManager.totalNutritOfDay["kcal"] ?? 0)/\(dataManager.caloriesNeed)")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("kcal")
                                        .foregroundColor(.secondary)
                                }
                                HStack{
                                    
                                    Text("p")
                                        .foregroundColor(.secondary)
                                    Text("\(dataManager.totalNutritOfDay["p"] ?? 0)g")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("c")
                                        .foregroundColor(.secondary)
                                    Text("\(dataManager.totalNutritOfDay["c"] ?? 0)g")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("f")
                                        .foregroundColor(.secondary)
                                    Text("\(dataManager.totalNutritOfDay["f"] ?? 0)g")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                }
                               
                                Spacer()
                                
                            }
                            
                            Spacer()
                            CustomProgressView(progress: animateProgress ? 0.0 : dataManager.progressCalories)
                        }
                        .padding(20)
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
                                .stroke(Color.openGreen,lineWidth:3)
                            
                            
                            VStack{
                                
                                HStack{
                                    Image(systemName: "figure.walk")
                                        .font(.caption)
                                        .padding(9)
                                        .foregroundColor(.white)
                                        .background(Color.openGreen)
                                        .clipShape(Circle())
                                    Text("activity")
                                        .fontDesign(.rounded)
                                        .fontWeight(.medium)
                                    Spacer()
                                    
                                }
                                
                                Spacer()
                                HStack{
                                    Text("\(dataManager.userStepCount)")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("steps")
                                    Spacer()
                                }
                                .padding(.horizontal)
                                Spacer()
                            }
                            .padding(10)
                            
                        }
                        .frame(width: screen.width / 2.1,height:110 )
                        ZStack{
                            // workouts hour
                            
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.red.opacity(0.5),lineWidth:3)
                            
                            VStack{
                                
                                HStack(spacing: 0){
                                    Image(systemName: "dumbbell")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(9)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                    Text("workouts")
                                        .fontDesign(.rounded)
                                        .fontWeight(.medium)
                                  Spacer()
                                    
                                }
                                
                                Spacer()
                                HStack{
                                    Text("\(dataManager.workoutMinutes)")
                                        .fontDesign(.monospaced)
                                        .fontWeight(.bold)
                                    Text("mins")
                                    Spacer()
                                }
                                .padding(.horizontal)
                                Spacer()
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal,5)
                            
                        }
                        .frame(width: screen.width / 2.1,height:110 )
                    }
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
                                
                                Spacer()
                                
                            }
                            
                            Spacer()
                        }
                        .padding(10)
                    }
                    .frame(width: screen.width / 1.05,height:130 )
                    
                    Spacer()
                    Button{
                        // add food
                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                            showAddView = true
                        }
                        
                        
                        
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
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name.NSCalendarDayChanged).receive(on: DispatchQueue.main)){_ in
                    // function for everyday 00;00
                }
                .transition(.move(edge: .top))
                .onAppear{
                    if !dataManager.isAuthorized{
                        dataManager.healthRequest()
                    }else{
                        dataManager.readStepsTakenToday()
                    }
                }
               
            }else{
                AddFoodView(namespace:namespace){
                    withAnimation(.interactiveSpring(response: 0.8,dampingFraction: 0.8)){
                        showAddView = false
                        
                        animateProgress = true
                        
                        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 0.2) {
                            animateProgress = false
                        }
                    }
                }
                .environmentObject(dataManager)
                .transition(.move(edge:  .bottom))
                
                
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NutritionData_Manager())
            .preferredColorScheme(.light)
    }
}
