//
//  SpeedOptionView.swift
//  Nutritionly
//
//  Created by aplle on 5/29/23.
//

import SwiftUI
enum SpeedOption:String ,CaseIterable {
    case slow = "Slow"
    case normal = "Normal"
    case fast = "Fast"
       
              
    
    var multiplier: Double {
        switch self {
        case .fast:
            return 1.5
        case .normal:
            return 1.0
        case .slow:
            return 0.5
        }
    }
}

struct SpeedOptionView: View {
    @AppStorage("speedMultiplier") var speedMultiplier = 0.5
    @State private var selectedSpeed = SpeedOption.slow
    @State private var next = false
    @State private var calculating = false
    var body: some View {

            ZStack{
            if next{
             TotalNutritionsView()
                    .transition(.move(edge: .bottom))
            }else{
                if calculating{
                    VStack{
                        Text("Calculating Data")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        ProgressView()
                    }
                    
                }else{
                VStack(spacing: 20){
                    Text("Choose your speed and start your route :)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    ForEach(SpeedOption.allCases,id:\.self){speed in
                        ZStack{
                            
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                .frame(height: 68)
                            
                                .overlay(alignment:.trailing){
                                    HStack{
                                        Image(speed.rawValue.lowercased())
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
                                .shadow(color:selectedSpeed == speed ? .green : .white, radius: 10)
                            
                            
                            VStack{
                                HStack{
                                    if speed == .slow{
                                        Text(speed.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                        
                                    }
                                    if speed == .normal{
                                        Text(speed.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                    }
                                    if speed == .fast{
                                        Text(speed.rawValue)
                                            .padding(.horizontal,10)
                                            .padding()
                                        Spacer()
                                    }
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                selectedSpeed = speed
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
                                speedMultiplier = selectedSpeed.multiplier
                                calculating = true
                                DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 2 ){
                                    
                                    next = true
                                }
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
}

struct SpeedOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedOptionView()
    }
}
