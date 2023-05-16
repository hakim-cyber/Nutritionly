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
    var namespace:Namespace.ID
    var close:()->Void
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
                .matchedGeometryEffect(id: "white background", in: namespace)
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
                            MealItem(foods: dataManager.foodsOfDay, meal: $0,color: dataManager.mealsColors[$0] ?? Color.openGreen)
                                .frame(maxHeight:  screen.size.height / 2.8)
                                .frame(minHeight: screen.size.height / 5.7)
                            
                        }
                    }
                  
                }
               

            }
           
        }
        .padding(.top)
        .padding(.horizontal)
       
        
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
