//
//  MainView-ViewModel.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import Foundation
import SwiftUI
import HealthKit
import WidgetKit

class NutritionData_Manager:ObservableObject{
    
  // User Has Pro Version
   
    
    
    
    //Nutrition Todays
    
    @AppStorage("caloriesNeed")  var caloriesNeed = 2000
   
    @AppStorage("proteinNeed") var proteinNeed = 80
   
    @AppStorage("carbohydratesNeed") var carbohydratesNeed = 120
  
    @AppStorage("fatsNeed") var fatsNeed = 70
    
    @AppStorage("drinkedWater") var drinkedWater = 0
   
    
    // BurningInformation Todays
    
    @AppStorage("workoutMinutes") var workoutMinutes = 0
    @AppStorage("requestweight") var requestweight = false
    
    @AppStorage("weightOfToday") var weightOfToday = 0.0
  
    
    // meals
    let meals = ["Breakfast","Lunch","Dinner","Snack"]
    let mealsColors:[String:Color] = ["Breakfast":Color("openGreen"), "Lunch":Color("purple"),"Dinner":Color("mint"),"Snack":Color("orange")]
    
    
    //foods of day and recent ones
    let keyforFoodsOfDay = "foodsOfDay"
    let keyforRecentFoods = "recentFoods"
    @Published var foodsOfDay = [Food]()
    @Published var recentFoodsOfUser = [Food]()
    
    // healthKit
    
    private var healthStore = HKHealthStore()
    @Published var userStepCount = 0
    @Published var userCalorieBurnedTodaysSteps = 0
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
    var nutritNeed:[String:Int]{
        
       return [
                    "kcal":caloriesNeed,
                    "p":proteinNeed,
                    "c":carbohydratesNeed,
                    "f":fatsNeed,
                
                
                ]
    }
    
    
    var calorieBurneWorkout:Int{
        let averageCaloriesPerMinute = 8.0
        
      let caloriesBurned = averageCaloriesPerMinute * Double(workoutMinutes)
        
        return Int(caloriesBurned)
    }
    
    //load all needed data when open
    init(){
       loadFoodsOfDay()
        loadRecentfoods()
            //health kit
        changeAuthorizationStatusSteps()
       
       
      
        
    }
    //start new day and new infos and upload all info to firebase
    func endOfDay(from date: Date) -> Date? {
           var calendar = Calendar.current
           calendar.timeZone = TimeZone.current
           
           // Get the components of the current date
           let components = calendar.dateComponents([.year, .month, .day], from: date)
           
           // Create the date components for the end of the day
           var endOfDayComponents = DateComponents()
           endOfDayComponents.year = components.year
           endOfDayComponents.month = components.month
           endOfDayComponents.day = components.day
           endOfDayComponents.hour = 23
           endOfDayComponents.minute = 59
           endOfDayComponents.second = 00
           
           // Get the end of the day date
           let endOfDay = calendar.date(from: endOfDayComponents)
           
           return endOfDay
       }
    func checkIfNewDay()->Bool {
            // Get the current date
      
            let currentDate = Date()
            
            // Compare the day components of the dates
            let calendar = Calendar.current
            let lastKnownDay = calendar.component(.day, from: loadLastKnownDate() )
            let currentDay = calendar.component(.day, from: currentDate)
            
            if lastKnownDay != currentDay {
                print("It's a new day!")
                print(loadLastKnownDate())
                return true
              
            } else {
                // Same day
                print("Same day")
                return false
           
            }
        }
    func updateLastKnownDate() {
            // Update the last known date with the current date
        
      let newDate = Date()
        saveLastKnownDate(newDate: newDate)
        }
  
    func saveLastKnownDate(newDate: Date) {
        if let encoded = try? JSONEncoder().encode(newDate) {
            UserDefaults.standard.set(encoded, forKey: "lastOpened")
            print("\(newDate) saving")
        }
    }
    func loadLastKnownDate() -> Date {
        if let data = UserDefaults.standard.data(forKey:"lastOpened") {
            if let decoded = try? JSONDecoder().decode(Date.self, from: data) {
                return decoded
            }
        }
        // Return the current date as a fallback if there's no saved date
        print("no saved")
        return Date()
    }
    func resetallInfo(){
        DispatchQueue.main.async {
            // reset date
            withAnimation(.easeInOut){
                self.workoutMinutes = 0
                self.weightOfToday = 0.0
                self.requestweight = true
                self.drinkedWater = 0
                self.foodsOfDay = []
                self.saveFoodsOfDay()
                self.readStepsTakenToday()
            }
        
        }
    }
    
    
    
    func addTodayToStore(store:UserStore){
       
        // read steps taken yesterday
        
        DispatchQueue.main.async {
            print("\(self.loadLastKnownDate()) adding day")
            if let endOfDay = self.endOfDay(from:  self.loadLastKnownDate()){
             
                print("\(endOfDay)")
                self.readStepCount(for: endOfDay, healthStore: self.healthStore){ [self]step in
                    if let order = store.userForApp.first?.days.count{
                     
                        let datestring = self.dateToString(date: endOfDay)
                        let day = Day(weightOFDay: self.weightOfToday, date: datestring, order: order, foods: self.foodsOfDay, workoutMinutes: self.workoutMinutes, walkingSteps: Int(step), waterIntake: self.drinkedWater)
                        
                        store.addDayToUser(day: day, to: store.userForApp.first!)
                        self.resetallInfo()
                        self.updateLastKnownDate()
                    }
                }
                
            }else{
                print("error end of day")
            }
                
        }
     
    }
    
    
    
      
    
    
//saving and loading foods
    func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()

        // Convert Date to String
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    func stringToDate(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let reverseDate = dateFormatter.date(from: string)
        return reverseDate ?? Date.now
       
    }
    func saveFoodsOfDay(){
        if let encoded = try? JSONEncoder().encode(foodsOfDay){
            UserDefaults.standard.set(encoded, forKey: keyforFoodsOfDay)
        }
    }
    func saveNutritsOfDay(){
        if let encoded = try? JSONEncoder().encode(totalNutritOfDay){
            if let defaults = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly"){
                defaults.set(encoded, forKey: "nutritOfDay")
              
                
                
                print("saveddd")
            }
        }
    }
    func saveNutritNeed(){
        if let encoded = try? JSONEncoder().encode(nutritNeed){
            if let defaults = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly"){
                defaults.set(encoded, forKey: "nutritNeed")
              
               
              
                print("saveddd")
            }
        }
    }
    func loadFoodsOfDay(){
        
        if let data =  UserDefaults.standard.data(forKey: keyforFoodsOfDay){
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
        
        
        withAnimation(.easeInOut){
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
            self.changeAuthorizationStatusSteps()
            
            self.readStepsTakenToday()
            
        }
    }
    func changeAuthorizationStatusSteps(){
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
       
        
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        DispatchQueue.main.async {
            
            switch status{
            case .notDetermined:
                self.isAuthorized = false
            case .sharingDenied:
                self.isAuthorized = false
            case .sharingAuthorized:
                withAnimation(.easeInOut){
                    self.isAuthorized = true
                }
            @unknown default:
                self.isAuthorized = false
            }
        }
    }
  
  
    func readStepsTakenToday(){
        readStepCount(for: Date(), healthStore: healthStore){step in
            if step != 0.0{
                DispatchQueue.main.async {
                               self.userStepCount = Int(step)
                           }
            }else{
                DispatchQueue.main.async {
                               self.userStepCount = 0
                           }
            }
        }
    }
   
    
    func setUpHealthRequest(healthStore:HKHealthStore,readSteps:@escaping ()-> Void){
    // then specify data we want to read
        // then ask for permission
        if HKHealthStore.isHealthDataAvailable(),let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount){
            healthStore.requestAuthorization(toShare: [stepCount], read: [stepCount]){succes, error in
                if succes{
                    readSteps()
                    
                }else if error != nil{
                    // handle error here
                }
                
                
            }
        }
    }
    
    
    func readStepCount(for Today:Date , healthStore:HKHealthStore,completion:@escaping (Double) -> Void){
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)else{return}
        let now = Today
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
  
    
   

    func calculateCaloriesBurned(weight: Double, steps: Int, height: Double, age: Int) -> Double {
        // Constants for calorie calculation
        let CALORIES_PER_STEP: Double = 0.04
        let CALORIES_PER_KILOGRAM: Double = 0.5
        let CALORIES_PER_CENTIMETER: Double = 0.02
        let CALORIES_PER_YEAR: Double = 2.3

        // Calculate calories burned based on weight, steps, height, and age
        let calories = (weight * CALORIES_PER_KILOGRAM) +
            (Double(steps) * CALORIES_PER_STEP) +
            (height * CALORIES_PER_CENTIMETER) -
            (Double(age) * CALORIES_PER_YEAR)

        return calories
    }

   


  
   






}
