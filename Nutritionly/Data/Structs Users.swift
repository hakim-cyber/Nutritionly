//
//  Structs Users.swift
//  Nutritionly
//
//  Created by aplle on 5/16/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User:Codable{
    @DocumentID var id:String?
    var name:String
    var email:String
    var height:Int
    var age:Int
    var gender:String
    var targetWeight:Double
    var days:[Day]
}

struct Day:Codable{
    var weightOFDay:Double
   var date:String
    var order:Int
    var foods:[Food]
    var workoutMinutes:Int
    var walkingSteps:Int
    var waterIntake:Int
}
struct Food:Codable{
    var id = UUID()
    var name:String
    var meal:String
    var ingredients:[Ingredients]
    
    var emoji = ""
    
   
}


struct Ingredients:Codable,Equatable{
    var grams = 100
    
    var id:UUID
    var fdcId:Int
    var title:String
    var calorie:Int
    var protein:Int
    var fat:Int
    var carbs:Int
    
    var totalNutritions:[String:Int]{
       let totalProtein = Int(protein * (grams / 100))
        let totalCarb =  Int(carbs * (grams / 100))
       let totalKcal =  Int(calorie * (grams / 100))
        let totalFats =  Int(fat * (grams / 100))
        return [
        "p":totalProtein,
        "c":totalCarb,
        "f":totalFats,
        "kcal":totalKcal
        
        ]
    }
}


struct Nutrition:Codable,Hashable{
    var name:String
    var count:Int
    var shortName:String
}
