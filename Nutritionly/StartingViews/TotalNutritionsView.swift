//
//  TotalNutritionsView.swift
//  Nutritionly
//
//  Created by aplle on 5/29/23.
//
import SwiftUI
import Firebase

struct TotalNutritionsView: View {
    @AppStorage("activityMultiplier") var activityMultiplier = 1.2
    @AppStorage("speedMultiplier") var speedMultiplier = 0.5
    @AppStorage("targetweight") var targetweight = 0.0
    @AppStorage("goal") var selectedGoal = "InShape"
    @AppStorage("height")  var height: Int = 150
    @AppStorage("age") var age: Int = 12
    @AppStorage("gender")  var selectedGender:String = "Male"
    
    
    @State var informationIsAdded = false
    
    @EnvironmentObject var dataManager:NutritionData_Manager
    @EnvironmentObject var userStore:UserStore
    var body: some View {
        if informationIsAdded{
            ContentView()
                .transition(.move(edge: .bottom))
        }else{
        VStack(spacing: 20){
            
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(.thinMaterial)
                VStack{
                    HStack{
                        Text("Daily Needs")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        
                        
                    }
                    Divider()
                    Spacer()
                    VStack(spacing: 10){
                        HStack{
                            Text("Calorie")
                            Spacer()
                            Text("\(dataManager.caloriesNeed)")
                                .fontWeight(.bold)
                        }
                        
                        HStack{
                            Text("Protein")
                            Spacer()
                            Text("\(dataManager.proteinNeed)")
                                .fontWeight(.bold)
                        }
                        HStack{
                            Text("Carbohydrate")
                            Spacer()
                            Text("\(dataManager.carbohydratesNeed)")
                                .fontWeight(.bold)
                        }
                        HStack{
                            Text("Fat")
                            Spacer()
                            Text("\(dataManager.fatsNeed)")
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                
            }
            .frame(height:300)
            
            Spacer()
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .padding(.top)
        .padding(.horizontal,20)
        .transition(.move(edge: .top))
        .safeAreaInset(edge: .bottom){
            HStack{
                Spacer()
                RoundedButtonView(text: "let's gooo", textColor: .white, backgroundColor: Color.buttonAndForegroundColor, action: {
                    withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                        storeUserInformation()
                    }
                    
                })
                .padding(20)
                .font(.title2)
            }
        }
        .onAppear{
            calculateNutritionNeeds(age: age, height: Double(height), weight: dataManager.weightOfToday, activityLevel: activityMultiplier, goal: selectedGoal, speedOption: speedMultiplier)
        }
    }
        
    }
   
    func calculateNutritionNeeds(age: Int, height: Double, weight: Double, activityLevel: Double, goal: String, speedOption: Double) {
           // Calculate Basal Metabolic Rate (BMR) using Harris-Benedict equation
           var bmr: Double
        if selectedGender == "male" {
            bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Double(age))
        } else {
            bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * Double(age))
        }
           
           // Apply activity level multiplier
           let activityMultiplier = activityMultiplier
           let calorieNeeds = bmr * activityMultiplier
           
           // Adjust calorie needs based on goal and speed option
           var adjustedCalories: Double
           switch goal {
           case "Lose":
               adjustedCalories = calorieNeeds - (500 * speedMultiplier)
           case "InShape":
               adjustedCalories = calorieNeeds
           case "Gain":
               adjustedCalories = calorieNeeds + (500 * speedMultiplier)
           default:
               adjustedCalories = calorieNeeds
           }
           
           // Calculate macronutrient needs based on the specified ratios
           let carbohydratePercentage = 0.45
           let proteinPercentage = 0.25
           let fatPercentage = 0.3
           
           let carbohydrate = adjustedCalories * carbohydratePercentage / 4.0 // 1 gram of carbohydrate is 4 calories
           let protein = adjustedCalories * proteinPercentage / 4.0 // 1 gram of protein is 4 calories
           let fat = adjustedCalories * fatPercentage / 9.0 // 1 gram of fat is 9 calories
           
        dataManager.caloriesNeed = Int(adjustedCalories)
        dataManager.carbohydratesNeed = Int(carbohydrate)
        dataManager.fatsNeed = Int(fat)
        dataManager.proteinNeed = Int(protein)
       }
    private func storeUserInformation(){
        do{
            guard let uid = Auth.auth().currentUser?.uid else{return}
            guard let email = Auth.auth().currentUser?.email else{return}
            
            let user = User(id:uid,name: "", email: email, height: height, age: age, gender: selectedGender, targetWeight: targetweight, days: [Day]())
        
            //adding user to firebase
            
            userStore.updateorAddUser(user: user)
           
                checkInforationIsAdded()
            
        }catch{
            print("errror")
        }
        
    }
    func checkInforationIsAdded(){
                  guard let uid = Auth.auth().currentUser?.uid else{return}
           guard let email = Auth.auth().currentUser?.email else{return}
                  let db = Firestore.firestore()
                  let docRef = db.collection("users").document(uid)
                  
                  docRef.getDocument { (document, error) in
                      if error != nil{
                          print(error?.localizedDescription as Any)
                         
                          return
                          
                      }
                      if let document = document{
                          
                          if document.exists {
                             
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

struct TotalNutritionsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalNutritionsView()
            .environmentObject(NutritionData_Manager())
            .environmentObject(UserStore())
    }
}
