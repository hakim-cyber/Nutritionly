//
//  NutritionlyApp.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI
import Firebase

@main
struct NutritionlyApp: App {
    @StateObject var dataManager = NutritionData_Manager()
    @StateObject var usersStore = UserStore()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .environmentObject(dataManager)
                .environmentObject(usersStore)
               
        }
    }
}
