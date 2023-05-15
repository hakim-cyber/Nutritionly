//
//  Data Controller.swift
//  Nutritionly
//
//  Created by aplle on 5/15/23.
//




import Foundation
import CoreData

class DataController:ObservableObject{
    let container = NSPersistentContainer(name: "Users")
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error{
                print("Core data Failed to load:\(error.localizedDescription)")
            }
        }
    }
}
