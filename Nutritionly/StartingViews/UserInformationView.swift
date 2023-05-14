//
//  UserInformationView.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI
import Firebase
struct UserInformationView: View {
    
    @State private var height: Int = 150
    @State private var weight: Int = 50
    @State private var age: Int = 12
    @State private var selectedGender:String = "Male"
   
 
    @State var genders = ["Male","Female"]
   @State var screen =  UIScreen.main.bounds
    
    @State var informationIsAdded = false
    var namespace:Namespace.ID
    var body: some View {
        if informationIsAdded{
            ContentView()
               
        }else{
        ZStack{
            BackGround(namespace: namespace)
       
                 
               
            
            VStack(spacing:30){
                HStack{
                    ZStack{
                        // age
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .fill(.white)
                            .padding(.horizontal,10)
                            .shadow(color: .black,radius: 10)
                        
                        VStack(spacing: 20){
                            Text("Age")
                            Text("\(age)")
                                .font(.system(size: 50))
                                .fontWeight(.heavy)
                            Spacer()
                            HStack(spacing: 20){
                                Button{
                                    if age != 80{
                                        
                                        self.age += 1
                                        
                                    }
                                }label: {
                                    ZStack{
                                        Circle()
                                            .stroke(.gray,lineWidth:1)
                                            .frame(width:30,height: 30)
                                        Image(systemName: "plus")
                                        
                                    }
                                }
                                Button{
                                    if age != 0{
                                        
                                        self.age -= 1
                                        
                                    }
                                }label: {
                                    ZStack{
                                        Circle()
                                            .stroke(.gray,lineWidth:1)
                                            .frame(width:30,height: 30)
                                        Image(systemName: "minus")
                                        
                                    }
                                }
                            }
                            
                            
                        }
                        .padding()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width/2 - 20,height: 220)
                    ZStack{
                        // weight
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .fill(.white)
                            .frame(width: screen.width/2.2,height: 220)
                            .padding(.horizontal,10)
                            .shadow(color: .black,radius: 10)
                        VStack(spacing: 20){
                            Text("Weight")
                            Text("\(weight)")
                                .font(.system(size: 50))
                                .fontWeight(.heavy)
                            Spacer()
                            HStack(spacing: 20){
                                Button{
                                    
                                    
                                    self.weight += 1
                                    
                                    
                                }label: {
                                    ZStack{
                                        Circle()
                                            .stroke(.gray,lineWidth:1)
                                            .frame(width:30,height: 30)
                                        Image(systemName: "plus")
                                        
                                    }
                                }
                                Button{
                                    if weight != 0{
                                        
                                        self.weight -= 1
                                        
                                    }
                                }label: {
                                    ZStack{
                                        Circle()
                                            .stroke(.gray,lineWidth:1)
                                            .frame(width:30,height: 30)
                                        Image(systemName: "minus")
                                        
                                    }
                                }
                            }
                            
                            
                        }
                        .padding()
                    }
                    .frame(width: screen.width/2.2,height: 220)
                    
                }
                
                ZStack{
                    // height
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(.white)
                        .padding(.horizontal,10)
                        .shadow(color: .black,radius: 10)
                    
                    VStack{
                        Text("Height")
                        Text("cm")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        Picker(selection: $height, label: Text("Data")) {
                        
                            ForEach(0...250, id: \.self) { high in
                                Text("\(high)")
                                }
                        }
                        .labelsHidden()
                        .pickerStyle(.wheel)
                        .clipped()
                    }
                    .padding()
                }
                .frame(width: screen.width / 1.2,height:200 )
                ZStack{
                    // gender
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(.white)
                        .padding(.horizontal,10)
                        .shadow(color: .black,radius: 10)
                    VStack{
                        Text("Gender")
                            .bold()
                        Spacer()
                        HStack{
                            Text("i'm")
                                .font(.system(size: 50))
                                .padding(.leading,20)
                                .fontWeight(.heavy)
                            Spacer()
                            
                            Picker("", selection: $selectedGender){
                                ForEach(genders, id: \.self){ 
                                    Text($0)
                                }
                                
                            }
                            .frame(maxWidth: 220)
                            .pickerStyle(.segmented)
                            .padding(.trailing,20)
                            
                        }
                        
                        
                    }
                    .padding(10)
                    
                }
                .frame(width: UIScreen.main.bounds.width / 1.2,height:100 )
                
                
            }
            
        }
        .safeAreaInset(edge: .bottom){
            HStack{
                Spacer()
                RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                  
                        storeUserInformation()
                    
                    
                    
                })
                .padding(20)
                .font(.title2)
            }
        }
        .onAppear{
           
                checkInforationIsAdded()
            
        }
    }
           
    }
    private func storeUserInformation(){
        do{
            guard let uid = Auth.auth().currentUser?.uid else{return}
            guard let email = Auth.auth().currentUser?.email else{return}
            let userData: [String: Any] = [
                   "email": email,
                   "id": uid,
                   "weight": weight,
                   "height": height,
                   "age": age,
                   "gender": selectedGender
               ]
            Firestore.firestore().collection("users").document(uid).setData(userData){error in
                if error != nil{
                    print(error?.localizedDescription as Any)
                    return
                }else{
                    checkInforationIsAdded()
                }
                
            }
           
                
            
        }catch{
            print("errror")
        }
        
    }
    func checkInforationIsAdded(){
               guard let uid = Auth.auth().currentUser?.uid else{return}
               let db = Firestore.firestore()
               let docRef = db.collection("users").document(uid)
               
               docRef.getDocument { (document, error) in
                   if error != nil{
                       print(error?.localizedDescription as Any)
                      
                       return
                       
                   }
                   if let document = document{
                       
                       if document.exists {
                           withAnimation(.easeIn(duration: 2)) {
                               self.informationIsAdded = true
                           }
                       } else {
                           return
                         
                       }
                   }else{
                       return
                   }
                   
                
               }
    }
}

struct UserInformationView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        UserInformationView(namespace: namespace)
    }
}
