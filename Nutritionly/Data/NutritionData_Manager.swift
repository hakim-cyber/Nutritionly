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
    
    // meals
    let meals = ["Breakfast","Lunch","Dinner","Snack"]
    let mealsColors:[String:Color] = ["Breakfast":Color.openGreen, "Lunch":Color.indigo,"Dinner":Color.mint,"Snack":Color.orange]
    
    
    //foods of day and recent ones
    let keyforFoodsOfDay = "foodsOfDay"
    @Published var foodsOfDay = [Food]()
    @Published var recentFoodsOfUser = [Food]()
    
    //load all needed data when open
    init(){
       loadFoodsOfDay()
    }
//saving and loading foods
    func saveFoodsOfDay(){
        if let encoded = try? JSONEncoder().encode(foodsOfDay){
            UserDefaults.standard.set(encoded, forKey: keyforFoodsOfDay)
        }
    }
    func loadFoodsOfDay(){
        
        if let data = UserDefaults.standard.data(forKey: keyforFoodsOfDay){
            if let decoded = try? JSONDecoder().decode([Food].self, from: data){
                foodsOfDay = decoded
            }
        }
    }
    /*
     var totals:[String:Int]{
       var totalProtein = 0
       var totalCarb = 0
       var totalKcal = 0
     var totalFats = 0
         
         for ingredient in ingredients {
             totalProtein += Int(ingredient.protein * (ingredient.grams / 100))
             totalCarb +=  Int(ingredient.carbs * (ingredient.grams / 100))
             totalKcal +=  Int(ingredient.calorie * (ingredient.grams / 100))
             totalFats +=  Int(ingredient.fat * (ingredient.grams / 100))
             
         }
         
         return [
         "p":totalProtein,
         "c":totalCarb,
         "f":totalFats,
         "kcal":totalKcal
         
         ]
     }
     */
    func AddNewFoodForDay(ingred:[Ingredients],name:String,meal:String){
        let food = Food(name: name, meal: meal, ingredients: ingred)
        
        foodsOfDay.append(food)
        saveFoodsOfDay()
    }
    
    
    var progressCalories:Double{
       Double( caloriesTaken) /  Double( caloriesNeed )
    }
    
    func minuteToHourText()->String{
        let hours = Int(workoutMinutes / 60)
        let minutes = Int(Double(workoutMinutes) -  Double(hours * 60))
        
        return String("\(hours)h \(minutes)m")
    }
    
    var nutritionsArray:[Nutrition]{
       
        let fats = Nutrition(name: "Fats", count: fatsTaken, shortName: "g")
        let cals = Nutrition(name: "Calories", count: fatsTaken, shortName: "kcal")
        let prot = Nutrition(name: "Proteins", count: fatsTaken, shortName: "g")
        let carb = Nutrition(name: "Carb", count: fatsTaken, shortName: "g")
        
        return [fats,carb,prot,cals]
    }
}
