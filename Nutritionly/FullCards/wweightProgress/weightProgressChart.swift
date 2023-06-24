//
//  weightProgressChart.swift
//  Nutritionly
//
//  Created by aplle on 5/24/23.
//

import SwiftUI
import Charts

struct weightProgressChart: View {
    @EnvironmentObject var userStore:UserStore
    @State private var screen = UIScreen.main.bounds
    @State private var animate = false
    
    var days:[Day]{
        userStore.fetchUserUsingThisApp()
        
        let days = (userStore.userForApp.first?.days ?? [Day]()).sorted{$0.order < $1.order}
        return days
    }
    var body: some View {
        
        
        VStack{
            ScrollView(.horizontal){
                VStack{
                    
                    Chart{
                        
                        ForEach(days, id:\.order) { day in
                            let date = stringToDate(string: day.date)
                            
                            BarMark(
                                x: .value("day",date,unit: .day),
                                y: .value("weight", animate ? day.weightOFDay:0)
                            )
                            .clipShape(RoundedRectangle(cornerRadius:30))
                            .foregroundStyle(Color.yellow.opacity(0.7))
                           
                            
                            
                            
                        }
                    }
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                   
                    
                    HStack{
                        if days.first != nil{
                            Text("\(days.first?.weightOFDay.formatted() ?? "\(0)")kg")
                                .font(.system(size: 8))
                                .foregroundColor(.secondary)
                                .bold()
                        }
                        Spacer()
                        Spacer()
                        if days.last != nil{
                            Text("\(days.last?.weightOFDay.formatted() ?? "\(0)")kg")
                                .font(.system(size: 8))
                                .foregroundColor(.secondary)
                                .bold()
                        }
                    }
                }
            }
            .frame(maxWidth: screen.width / 1.09) // <<
            .frame(maxHeight:80)
        }
        .padding(.horizontal,5)
        .onAppear(perform: loadDaysOfUser)
        .onChange(of: days.count){_ in
            loadDaysOfUser()
        }
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
    
    
    func stringToDate(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let reverseDate = dateFormatter.date(from: string)
        return reverseDate ?? Date.now
       
    }
    func loadDaysOfUser(){
        withAnimation(.easeInOut.delay(0.5)){
            animate = true
        }
    }
}


struct weightProgressChart_Previews: PreviewProvider {
    static var previews: some View {
        weightProgressChart()
            .environmentObject(UserStore())
    }
}
