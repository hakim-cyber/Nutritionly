//
//  Water IntakeCard.swift
//  Nutritionly
//
//  Created by aplle on 5/22/23.
//

import SwiftUI

struct Water_IntakeCard: View {
    @State var screen = UIScreen.main.bounds
    @EnvironmentObject var dataManager :NutritionData_Manager
    
    @State private var totalCount = 7
    
    var drinkedCount:Int{
        return Int(dataManager.drinkedWater / 300)
    }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue.opacity(0.5),lineWidth:3)
            
            VStack{
                HStack(spacing: 5){
                    Image(systemName: "drop.fill")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(7)
                        .background(Color.blue.opacity(0.5))
                        .clipShape(Circle())
                    Text("Water")
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
                    Spacer()
                    
                }
                Spacer()
                if !(drinkedCount == totalCount){
                    HStack(spacing: 12){
                        ForEach(1...totalCount,id:\.self){index in
                            VStack{
                                Image(systemName: "drop.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(calculateDrinked(index: index) ? .blue.opacity(0.5):.gray.opacity(0.7))
                                    .animation(.interactiveSpring(response: 0.6,dampingFraction: 0.6), value: drinkedCount)
                                Text("300ml")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }else{
                    Text("You Accomplished Water Intake 💧")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                Spacer()
                
            }
            .padding(10)
        }
        .onTapGesture {
            if drinkedCount < totalCount{
                
                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                    DispatchQueue.main.async {
                        dataManager.drinkedWater += 300
                    }
                }
            }
        }
        .animation(.interactiveSpring(response: 0.6,dampingFraction: 0.6), value: drinkedCount)
       
        .frame(width: screen.width / 1.05,height:130 )
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                       
                   // Give a moment for the screen boundaries to change after
                   // the device is rotated
                   Task { @MainActor in
                       try await Task.sleep(for: .seconds(0.001))
                       withAnimation{
                           self.screen = UIScreen.main.bounds
                       }
                   }
               }
        .onAppear{
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.001))
                withAnimation{
                    self.screen = UIScreen.main.bounds
                }
            }
        }
    }
    
    func calculateDrinked(index:Int)->Bool{
        if index <= drinkedCount{
            return true
        }else{
            return false
        }
    }
}

struct Water_IntakeCard_Previews: PreviewProvider {
    static var previews: some View {
        Water_IntakeCard()
            .environmentObject(NutritionData_Manager())
    }
}
