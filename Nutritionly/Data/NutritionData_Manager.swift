//
//  MainView-ViewModel.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import Foundation

class NutritionData_Manager:ObservableObject{
    //Nutrition Todays
    @Published  var caloriesNeed = 1600
    @Published var caloriesTaken = 1200
    @Published var proteinNeed = 120
    @Published var proteinTaken = 80
    @Published var carbohydratesNeed = 150
    @Published var carbohydratesTaken = 130
    @Published var fatsNeed = 80
    @Published var fatsTaken = 60
    
    // BurningInformation Todays
    
    @Published var workoutMinutes = 105
    @Published var steps = 5000
    
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
