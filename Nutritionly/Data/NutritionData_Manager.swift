//
//  MainView-ViewModel.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import Foundation
import SwiftUI
import HealthKit

class NutritionData_Manager:ObservableObject{
    //Nutrition Todays
    
    @AppStorage("caloriesNeed")  var caloriesNeed = 2000
   
    @AppStorage("proteinNeed") var proteinNeed = 80
   
    @AppStorage("carbohydratesNeed") var carbohydratesNeed = 120
  
    @AppStorage("fatsNeed") var fatsNeed = 70
   
    
    // BurningInformation Todays
    
    @AppStorage("workoutMinutes") var workoutMinutes = 0
  
    
    // meals
    let meals = ["Breakfast","Lunch","Dinner","Snack"]
    let mealsColors:[String:Color] = ["Breakfast":Color.openGreen, "Lunch":Color.indigo,"Dinner":Color.mint,"Snack":Color.orange]
    
    
    //foods of day and recent ones
    let keyforFoodsOfDay = "foodsOfDay"
    let keyforRecentFoods = "recentFoods"
    @Published var foodsOfDay = [Food]()
    @Published var recentFoodsOfUser = [Food]()
    
    // healthKit
    
    private var healthStore = HKHealthStore()
    @Published var userStepCount = ""
    @Published var isAuthorized = false
    
    var totalNutritOfDay:[String:Int]{
        var calories = 0
        var proteins = 0
        var carbs = 0
        var fats = 0
        
        for food in foodsOfDay {
            for ingred in food.ingredients{
                calories += ingred.totalNutritions["kcal"] ?? 0
                proteins += ingred.totalNutritions["p"] ?? 0
                carbs += ingred.totalNutritions["c"] ?? 0
                fats += ingred.totalNutritions["f"] ?? 0
            }
        }
        
        return [
            "kcal":calories,
            "p":proteins,
            "c":carbs,
            "f":fats,
        
        
        ]
        
    }
    
    //load all needed data when open
    init(){
       loadFoodsOfDay()
        loadRecentfoods()
            //health kit
        changeAuthorizationStatus()
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
    // recent uploaded foods
    func saveRecentFoods(){
        if let encoded = try? JSONEncoder().encode(recentFoodsOfUser){
            UserDefaults.standard.set(encoded, forKey: keyforRecentFoods)
        }
    }
    func loadRecentfoods(){
        
        if let data = UserDefaults.standard.data(forKey: keyforRecentFoods){
            if let decoded = try? JSONDecoder().decode([Food].self, from: data){
                recentFoodsOfUser = decoded
            }
        }
    }
    
   
    func AddNewFoodForDay(ingred:[Ingredients],name:String,meal:String,emoji:String?){
        let food = Food(name: name, meal: meal, ingredients: ingred,emoji: emoji ?? "")
        
        
        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
            foodsOfDay.append(food)
            
            if !(recentFoodsOfUser.contains(where: {$0.ingredients == food.ingredients})){
                recentFoodsOfUser.append(food)
                saveRecentFoods()
            }
            
            saveFoodsOfDay()
        }
    }
    
    
    var progressCalories:Double{
       Double( totalNutritOfDay["kcal"] ?? 0) /  Double( caloriesNeed )
    }
    
    func minuteToHourText()->String{
        let hours = Int(workoutMinutes / 60)
        let minutes = Int(Double(workoutMinutes) -  Double(hours * 60))
        
        return String("\(hours)h \(minutes)m")
    }
    
    var nutritionsArray:[Nutrition]{
       
        let fats = Nutrition(name: "Fats", count: totalNutritOfDay["f"] ?? 0, shortName: "g")
        let cals = Nutrition(name: "Calories", count: totalNutritOfDay["kcal"] ?? 0, shortName: "kcal")
        let prot = Nutrition(name: "Proteins", count: totalNutritOfDay["p"] ?? 0, shortName: "g")
        let carb = Nutrition(name: "Carb", count: totalNutritOfDay["c"] ?? 0, shortName: "g")
        
        return [fats,carb,prot,cals]
    }
    
    
    
    func healthRequest(){
        setUpHealthRequest(healthStore: healthStore){
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    func changeAuthorizationStatus(){
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        switch status{
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            isAuthorized = true
        @unknown default:
            isAuthorized = false
        }
    }
    func readStepsTakenToday(){
        readStepCount(forToday: Date(), healthStore: healthStore){step in
            if step != 0.0{
                DispatchQueue.main.async {
                               self.userStepCount = String(format: "%.0f", step)
                           }
            }
        }
    }
    
    func setUpHealthRequest(healthStore:HKHealthStore,readSteps:@escaping ()-> Void){
    // then specify data we want to read
        // then ask for permission
        if HKHealthStore.isHealthDataAvailable(), let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount){
            healthStore.requestAuthorization(toShare: [stepCount], read: [stepCount]){succes, error in
                if succes{
                    readSteps()
                }else if error != nil{
                    // handle error here
                }
                
                
            }
        }
    }
    
    
    func readStepCount(forToday:Date , healthStore:HKHealthStore,completion:@escaping (Double) -> Void){
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)else{return}
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now,options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result ,let sum = result.sumQuantity()else{
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        healthStore.execute(query)
    }
    
}
