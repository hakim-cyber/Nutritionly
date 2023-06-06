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
import FirebaseAuth



class UserStore:ObservableObject{
    @Published var userForApp = [User]()
    
    @Published  var userIsLoggedIn = false
 
    let db = Firestore.firestore()
    
    
    init(){
       fetchUserUsingThisApp()
    }
   
    func logOut(){
        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){

                do{
                    
                    try Auth.auth().signOut()
                    self.userIsLoggedIn = false
                    
                }catch{
                    print("\(error) signing out error")
                }
            }
        
    }
   
    func addDayToUser(day:Day,to user:User){
        var userForAdd = user
        userForAdd.days.append(day)
        
        updateorAddUser(user: userForAdd)
    }
    func fetchUserUsingThisApp(){
        guard let idOfUser = Auth.auth().currentUser?.uid else{return}
        
        fetchUser(userId: idOfUser)
    }
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
    func updateorAddUser(user:User){
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
