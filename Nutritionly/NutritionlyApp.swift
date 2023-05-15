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
    @StateObject private var dataController = DataController()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .environmentObject(dataManager)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
