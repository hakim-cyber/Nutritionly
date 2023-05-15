//
//  UserStore.swift
//  Nutritionly
//
//  Created by aplle on 5/16/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift



class UserStore:ObservableObject{
    @Published var userForApp = [User]()
    let db = Firestore.firestore()
    
    
    
    
    func fetchUser(userId:String){
        let docRef = db.collection("users").document(userId)
        
        docRef.getDocument{document,error in
            if let error = error as NSError?{
               print("Error getting users document")
            }else{
                if let document = document{
                    do{
                        self.userForApp = [try document.data(as: User.self)]
                    }catch{
                        print(error)
                    }
                }
            }
            
        }
    }
    func updateUser(user:User){
        // Use for updating user ,adding with id you want , if no id it uses adding new user
        
        
        if let id = user.id{
            let docref = db.collection("users").document(id)
            
            do{
                try docref.setData(from: user)
                
            }catch{
                print(error)
            }
        }else{
            addUser(user: user)
        }
    }
    
    func addUser(user:User){
        let collectionRef = db.collection("users")
        
        do{
            let newDocReference = try collectionRef.addDocument(from: user)
            print("User Stored with new document reference = \(newDocReference)")
        }catch{
            print(error)
        }
    }
    
    
}
