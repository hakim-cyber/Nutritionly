//
//  MainView-ViewModel.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import Foundation
import SwiftUI

class NutritionData_Manager:ObservableObject{
    //Nutrition Todays
    
    @AppStorage("caloriesNeed")  var caloriesNeed = 0
    @AppStorage("caloriesTaken") var caloriesTaken = 0
    @AppStorage("proteinNeed") var proteinNeed = 0
    @AppStorage("proteinTaken") var proteinTaken = 0
    @AppStorage("carbohydratesNeed") var carbohydratesNeed = 0
    @AppStorage("carbohydratesTaken") var carbohydratesTaken = 0
    @AppStorage("fatsNeed") var fatsNeed = 0
    @AppStorage("fatsTaken") var fatsTaken = 0
    
    // BurningInformation Todays
    
    @AppStorage("workoutMinutes") var workoutMinutes = 0
    @AppStorage("steps") var steps = 0
    
    //Food information Todays
    
    var progressCalories:Double{
       Double( caloriesTaken) /  Double( caloriesNeed )
    }
    
    func minuteToHourText()->String{
        let hours = Int(workoutMinutes / 60)
        let minutes = Int(Double(workoutMinutes) -  Double(hours * 60))
        
        return String("\(hours)h \(minutes)m")
    }
    
    
}
