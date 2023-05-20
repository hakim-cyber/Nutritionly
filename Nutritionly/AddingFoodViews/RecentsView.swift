//
//  RecentsView.swift
//  Nutritionly
//
//  Created by aplle on 5/20/23.
//

import SwiftUI



struct RecentsView: View {
    @EnvironmentObject var dataManager:NutritionData_Manager
    @Binding var selectedFood:Food?
    @State private var screen = UIScreen.main.bounds
    var body: some View {
       
                ScrollView(.vertical,showsIndicators: false){
                    LazyVStack{
                        ForEach(Array(dataManager.recentFoodsOfUser.indices) , id:\.self){index in
                            HStack{
                                CustomCheckMark(selected: isSelected(food: dataManager.recentFoodsOfUser[index]), size: 25)
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                                        .fill(.ultraThinMaterial)
                                        .shadow(radius: 5)
                                        .opacity(0.7)
                                    
                                    VStack(alignment: .center,spacing:10){
                                        let totalsNutrition = total(ingredients: dataManager.recentFoodsOfUser[index].ingredients)
                                       
                                            Text("\(dataManager.recentFoodsOfUser[index].name)")
                                            .font(.system(size: 20))
                                            .fontDesign(.monospaced)
                                            .fontWeight(.heavy)
                                            .multilineTextAlignment(.leading)
                                            HStack{
                                                
                                                Text("p")
                                                    .foregroundColor(.secondary)
                                                Text("\(totalsNutrition["p"] ?? 0)g")
                                                    .fontDesign(.monospaced)
                                                    .fontWeight(.bold)
                                                Text("c")
                                                    .foregroundColor(.secondary)
                                                Text("\(totalsNutrition["c"] ?? 0)g")
                                                    .fontDesign(.monospaced)
                                                    .fontWeight(.bold)
                                                Text("f")
                                                    .foregroundColor(.secondary)
                                                Text("\(totalsNutrition["f"] ?? 0)g")
                                                    .fontDesign(.monospaced)
                                                    .fontWeight(.bold)
                                                
                                                Text("\(totalsNutrition["kcal"] ?? 0)kcal")
                                                    .fontDesign(.monospaced)
                                                    .fontWeight(.bold)
                                                
                                                
                                            }
                                            
                                            
                                           
                                        
                                 
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical,10)
                                }
                                .frame(maxHeight: screen.height / 13)
                                
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                            .onTapGesture {
                                if isSelected(food: dataManager.recentFoodsOfUser[index]){
                                    withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                        selectedFood = nil
                                    }
                                }else{
                                    withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                        selectedFood = dataManager.recentFoodsOfUser[index]
                                    }
                                }
                            }
                        }
                    }
                }
                
                
    
      
    }
    
    func isSelected(food:Food)->Bool{
        if selectedFood != nil{
            if selectedFood?.ingredients == food.ingredients && selectedFood?.name == food.name
                && selectedFood?.meal == food.meal{
                return true
                
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func total(ingredients:[Ingredients])->[String:Int]{
        var totalProtein = 0
        var totalCarb = 0
        var totalKcal = 0
      var totalFats = 0
          
          for ingredient in ingredients {
              totalProtein += ingredient.totalNutritions["p"] ?? 0
              totalCarb +=  ingredient.totalNutritions["c"] ?? 0
              totalKcal +=  ingredient.totalNutritions["kcal"] ?? 0
              totalFats +=  ingredient.totalNutritions["f"] ?? 0
              
          }
          
          return [
          "p":totalProtein,
          "c":totalCarb,
          "f":totalFats,
          "kcal":totalKcal
          
          ]
    }
}

struct RecentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsView(selectedFood: .constant(nil))
            .environmentObject(NutritionData_Manager())
    }
}



/*
 HStack{
     CustomCheckMark(selected: isSelected(ingred: ingred), size: 23)
     ZStack{
         RoundedRectangle(cornerRadius: 10,style: .continuous)
             .fill(.ultraThinMaterial)
             .shadow(radius: 5)
             .opacity(0.7)
         
         VStack{
             HStack{
                 Text("\(ingred.title)")
                 Spacer()
                 
             }
             
             HStack{
                 
                 Text("p")
                     .foregroundColor(.secondary)
                 Text("\(ingred.protein)g")
                     .fontDesign(.monospaced)
                     .fontWeight(.bold)
                 Text("c")
                     .foregroundColor(.secondary)
                 Text("\(ingred.carbs)g")
                     .fontDesign(.monospaced)
                     .fontWeight(.bold)
                 Text("f")
                     .foregroundColor(.secondary)
                 Text("\(ingred.fat)g")
                     .fontDesign(.monospaced)
                     .fontWeight(.bold)
                 
                 Text("\(ingred.calorie)kcal")
                     .fontDesign(.monospaced)
                     .fontWeight(.bold)
                 
                 
             }
             
         }
         .padding(.leading,1)
         .padding(.horizontal,5)
         .padding(5)
     }
     
     
 }
 */
