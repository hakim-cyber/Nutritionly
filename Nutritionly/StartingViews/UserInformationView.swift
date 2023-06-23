//
//  UserInformationView.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI
import Firebase
struct UserInformationView: View {
   
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var dataManager :NutritionData_Manager
    
  
    @State private var weightInt = 50
    @State private var weightDouble = 1
    
    @AppStorage("height")  var height: Int = 150
    
    @AppStorage("age") var age: Int = 12
    @AppStorage("gender")  var selectedGender:String = "Male"
   

    @State var genders = ["Male","Female"]
   @State var screen =  UIScreen.main.bounds
    
    @State var informationIsAdded = false
    @State var checked = false
    @State var animated = false
    @State private var next = false
    
    var weight:Double{
        Double(weightInt) + Double(weightDouble) / 10
    }
    var namespace:Namespace.ID
    var body: some View {
        if informationIsAdded{
            ContentView()
               
               
        }else{
            ZStack{
                BackGround2(namespace: namespace,animated: animated)
                
                
                
                if next{
                    GoalView()
                        .transition(.move(edge: .bottom))
                }else{
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
                            .frame(width: screen.width/2.1,height: screen.height / 3.3 )
                            ZStack{
                                // weight
                                RoundedRectangle(cornerRadius: 15,style: .continuous)
                                    .fill(.white)
                                    .padding(.horizontal,10)
                                    .shadow(color: .black,radius: 10)
                                VStack(spacing: 20){
                                    Text("Weight")
                                    Text("\(weight.formatted())")
                                        .font(.system(size: 30))
                                        .fontWeight(.heavy)
                                  MultipleSectionWeightPicker(weightInt: $weightInt, weightDouble: $weightDouble)
                                    
                                    
                                }
                                .padding()
                            }
                            .frame(width: screen.width/2.1,height: screen.height / 3.2 )
                            
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
                                            .foregroundColor(.black)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                .clipped()
                            }
                            .padding()
                        }
                        .frame(width: screen.width / 1.1,height:screen.height/5 )
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
                                                .foregroundColor(.black)
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
                    .safeAreaInset(edge: .bottom){
                        HStack{
                            Spacer()
                            RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                                
                                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                    dataManager.weightOfToday = weight
                                    next = true
                                }
                                
                                
                                
                            })
                            .disabled(checked == false)
                            .padding(20)
                            .font(.title2)
                        }
                    }
                    .onAppear{
                        DispatchQueue.main.async {
                            checkInforationIsAdded()
                            checked = true
                        }
                       
                        
                    }
                    .padding(.vertical)
                }
            }
            .foregroundColor(.black)
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
                          
                           withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                             
                               self.animated = true
                           }
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                               withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)) {
                                   self.informationIsAdded = true
                               }
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
            .environmentObject(NutritionData_Manager())
    }
}
