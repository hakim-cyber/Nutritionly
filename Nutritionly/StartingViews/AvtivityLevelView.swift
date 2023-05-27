//
//  AvtivityLevelView.swift
//  Nutritionly
//
//  Created by aplle on 5/27/23.
//

import SwiftUI
enum ActivityLevel: String, CaseIterable{
    case sedentary = "Sedentary"
    case lightlyActive = "Lightly active"
    case moderatelyActive = "Moderately active"
    case veryActive =  "Very active"
    case extremelyActive  = "Extremely active"
    
    var multiplier:Double{
        switch self{
        case .sedentary:
            return 1.2
        case .lightlyActive:
            return 1.375
        case .moderatelyActive:
        return 1.55
        case .veryActive:
            return 1.725
        case .extremelyActive:
            return 1.9
        }
    }
}

struct ActivityLevelView: View {
    @AppStorage("activityMultiplier") var activityMultiplier = 1.2
    @State private var selectedLevel = ActivityLevel.sedentary
    @State private var showInfo = false
    @State private var next = false
    var body: some View {
        ZStack{
            if next{
                
            }else{
                
                VStack(spacing: 20){
                    Text("What you would like to achive ?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    ForEach(ActivityLevel.allCases,id:\.self){level in
                        ZStack{
                            
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                .frame(height: 78)
                            
                                .overlay(alignment:.trailing){
                                    HStack{
                                       
                                        Image(level.rawValue.lowercased())
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60)
                                            .mask(RoundedRectangle(cornerRadius: 15)
                                                .fill(.ultraThinMaterial)
                                                .frame(height: 78))
                                            .edgesIgnoringSafeArea(.all)
                                      
                                    }
                                    .padding(.horizontal,30)
                                }
                                .clipped(antialiased:false)
                                .shadow(color:selectedLevel == level ? .green : .white, radius: 10)
                            
                            
                            VStack{
                                
                                HStack{
                                    if level == .sedentary{
                                        Text(level.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                        
                                    }
                                    if level == .lightlyActive{
                                        Text(level.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                    }
                                    if level == .moderatelyActive{
                                        Text(level.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                    }
                                    if level == .veryActive{
                                        Text(level.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                     
                                    }
                                    if level == .extremelyActive{
                                        Text(level.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                    }
                                    
                                }
                            }
                  
                            
                            
                            
                            
                        }
                        .overlay(alignment:.topTrailing){
                            Button{
                                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                    selectedLevel = level
                                    showInfo = true
                                }
                            }label:{
                                Image(systemName: "info.circle")
                                    .foregroundColor(Color.buttonAndForegroundColor)
                            }
                            .padding(7)
                        }
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                selectedLevel = level
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
                            withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                activityMultiplier = selectedLevel.multiplier
                                next = true
                            }
                            
                        })
                        .padding(20)
                        .font(.title2)
                    }
                }
               
                
                if showInfo{
                infoView(level: selectedLevel)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
   
    @ViewBuilder
    func infoView(level:ActivityLevel)->some View{
        VStack{
                HStack{
                    Spacer()
                    Image(systemName:"xmark.circle")
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                showInfo = false
                            }
                        }
                    
                    
                }
                .padding()
                VStack(alignment: .leading, spacing:30){
                switch level {
                case .sedentary:
                    Text("▪️ Office work (sitting at a desk for most of the day)")
                    Text("▪️ Watching TV or reading")
                    Text("▪️ Minimal physical activity throughout the day")
                case .lightlyActive:
                    Text("▪️ Light exercise or sports 1-3 days per week (e.g., leisurely walking, yoga)")
                    Text("▪️ Active commuting (e.g., cycling to work)")
                    Text("▪️ Some household chores (e.g., light cleaning)")
                    
                case .moderatelyActive:
                    Text("▪️ Regular exercise or sports 3-5 days per week (e.g., jogging, swimming, dancing)")
                    Text("▪️ Active job (e.g., waiter/waitress, delivery driver)")
                    Text("▪️ Moderate intensity physical activities during leisure time")
                case .veryActive:
                    Text("▪️ Intense exercise or sports 6-7 days per week (e.g., running, weightlifting, competitive sports)")
                    Text("▪️ Physically demanding job (e.g., construction worker, professional athlete)")
                    Text("▪️ Engaging in multiple physical activities throughout the day")
                case .extremelyActive:
                    Text("▪️ Endurance training or professional-level sports (e.g., marathon training, professional athlete preparing for competition)")
                    Text("▪️ Highly physically demanding job (e.g., firefighter, military personnel)")
                    Text("▪️ Rigorous training sessions and multiple intense physical activities daily")
                }
            }
            .padding()
            .padding(.bottom)
            
                
        }
        .foregroundColor(.white)
        .background(Color.buttonAndForegroundColor)
        .cornerRadius(20)
        .padding(.horizontal,30)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        
     
      
     
        
    }
}

struct ActivityLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLevelView()
    }
}
