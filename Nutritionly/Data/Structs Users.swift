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
    var days:[Day]
}

struct Day:Codable{
    var weightOFDay:Int
    var order:Int
    var foods:[Food]
    var workoutMinutes:Int
    var walkingSteps:Int
}
struct Food:Codable{
    var name:String
    var meal:String
    var ingredients:[Ingredients]
}

struct Ingredients:Codable{
    var calorie:Int
    var protein:Int
    var fat:Int
    var carbs:Int
}
