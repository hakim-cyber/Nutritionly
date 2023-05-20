//
//  AddFoodView.swift
//  Nutritionly
//
//  Created by aplle on 5/16/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct AddFoodView: View {
    @EnvironmentObject var dataManager:NutritionData_Manager
    @State var screen = UIScreen.main.bounds
    @State private var showaddingNewFood = false
    @State private var selectedMeal:String?
    var namespace:Namespace.ID
    var close:()->Void
    var body: some View {
        ZStack{
            if !showaddingNewFood{
                ZStack{
                    Color.white.ignoresSafeArea()
                      
                    VStack(spacing: 20){
                        HStack{
                            Button{
                                
                                close()
                                
                            }label: {
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text("daily food")
                                    .foregroundColor(.black)
                                    .font(.system(size: 40))
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                                
                            }
                            .padding(.horizontal, 10)
                            
                            Spacer()
                            
                        }
                        NutritionsLine()
                        
                        ScrollView(.vertical,showsIndicators: false){
                            VStack(spacing: 25){
                                ForEach(dataManager.meals,id: \.self){
                                    MealItem(foods: dataManager.foodsOfDay, meal: $0,color: dataManager.mealsColors[$0] ?? Color.openGreen, nameSpace: namespace){selectedMeal in
                                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.8)){
                                            self.selectedMeal = selectedMeal
                                            self.showaddingNewFood = true
                                        }
                                    }
                                    .frame(maxHeight:  screen.size.height / 3.05)
                                    .frame(minHeight: screen.size.height / 5.7)
                                    
                                }
                            }
                            
                        }
                        
                        
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .opacity(showaddingNewFood ? 0 : 1)
            }else{
                if let selectedMeal = selectedMeal{
                    NewFoodView(meal: selectedMeal , color: dataManager.mealsColors[selectedMeal] ?? Color.openGreen,namespace: namespace){
                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.8)){
                            self.showaddingNewFood = false
                            self.selectedMeal = nil
                        }
                    }
                    .opacity(showaddingNewFood ? 1 : 0)
                }
            }
           
        }
       
       
        
    }
}

struct AddFoodView_Previews: PreviewProvider {
 @Namespace static var namespace
    static var previews: some View {
        AddFoodView(namespace: namespace){
            
        }
            .environmentObject(NutritionData_Manager())
    }
}
