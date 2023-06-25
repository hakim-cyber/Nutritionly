//
//  MyTargetView.swift
//  Nutritionly
//
//  Created by aplle on 6/9/23.
//

import SwiftUI

struct MyTargetView: View {
    @EnvironmentObject var userStore :UserStore
    @EnvironmentObject var dataManager:NutritionData_Manager
    var days:[Day]{
        if  self.userStore.userForApp.count > 0{
          DispatchQueue.global().async {
              self.userStore.fetchUserUsingThisApp()
          }
         
            return self.userStore.userForApp.first?.days.sorted{$0.order < $1.order} ?? []
      }else{
          return []
      }
    }
    var targetweight:Double{
        userStore.userForApp.first?.targetWeight ?? 0
    }
    var startWeight:Double{
        days.first?.weightOFDay ?? currentWeight
    }
    var currentWeight:Double{
        dataManager.weightOfToday
    }
    var progres:Double{
      
        
        let progressKgs = currentWeight - startWeight
        
        return Double(progressKgs)
    }
    var body: some View {
        Form{
            Section{
                HStack{
                    Text("Start Weight")
                    Spacer()
                    Text("\(startWeight.formatted())")
                        .bold()
                    
                }
                HStack{
                    Text("Current Weight")
                    Spacer()
                    Text("\(currentWeight.formatted())")
                        .bold()
                }
                HStack{
                    Text("Target Weight")
                    Spacer()
                    Text("\(targetweight.formatted())")
                        .bold()
                }
            }
            Section{
                HStack{
                    Spacer()
                    if progres < 0{
                        Text("Your Progress \(String(format: "-%.01f", -progres)) Kg🔥")
                            .bold()
                            .font(.title3)
                    }else{
                        Text("Your Progress \(String(format: "%.01f", progres)) Kg🔥")
                            .bold()
                            .font(.title3)
                    }
                    Spacer()
                    
                }
            }
            
        }
    }
}

struct MyTargetView_Previews: PreviewProvider {
    static var previews: some View {
        MyTargetView()
            .environmentObject(UserStore())
            .environmentObject(NutritionData_Manager())
    }
}
