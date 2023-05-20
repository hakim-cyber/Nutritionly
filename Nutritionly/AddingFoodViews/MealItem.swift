//
//  MealItem.swift
//  Nutritionly
//
//  Created by aplle on 5/17/23.
//

import SwiftUI

struct MealItem: View {
    var foods:[Food]
    var meal:String
    var color:Color
    var nameSpace:Namespace.ID
    var showAddingNewFood:(String)->Void
  
    var body: some View {
   
      
          
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20,style: .continuous)
                        .stroke(.gray,lineWidth:1)
                    
                    VStack(spacing: 14){
                        HStack(alignment: .center){
                            Text(meal)
                                .bold()
                                .foregroundColor(.black)
                            Button{
                                // add day with this meal
                                showAddingNewFood(meal)
                            }label: {
                                Image(systemName: "plus")
                                    .padding(5)
                                    .font(.caption)
                                    .foregroundColor(Color.backgroundColor)
                                    .background(Circle().stroke(.black))
                            }
                            Spacer()
                            
                            Text("\(totalCals) kcal")
                                .bold()
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20,style: .continuous)
                                .fill(color)
                                .matchedGeometryEffect(id: "Background\(meal)", in: nameSpace)
                               
                            ScrollView(.vertical,showsIndicators: false){
                                VStack(alignment: .leading, spacing: 15){
                                    ForEach(filteredFoods, id:\.name) { food in
                                        VStack{
                                            HStack(alignment: .center){
                                                VStack(alignment: .leading,spacing: 10){
                                                    Text(food.name)
                                                        .foregroundColor(.white)
                                                        .bold()
                                                        .fontDesign(.rounded)
                                                        .font(.system(size: 18))
                                                    Text("\(totalCal(for:food)) kcal")
                                                        .foregroundColor(.white)
                                                        .fontWeight(.light)
                                                        .fontDesign(.rounded)
                                                        .font(.system(size: 15))
                                                }
                                                
                                                Spacer()
                                                
                                                // place for image in future
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 60,height: 60)
                                                
                                                
                                                
                                            }
                                            Rectangle()
                                                .fill(.white.opacity(0.2))
                                                .frame(height: 1.5)
                                            
                                            
                                        }
                                        .padding(.vertical,10)
                                        
                                    }
                                }
                                .padding()
                            }
                        }
                        
                    }
                
                
                
            }
                .padding(.horizontal)
        
           
        
      
    }
    var filteredFoods:[Food]{
        foods.filter{$0.meal == meal}
    }
    var totalCals:Int{
        var total = 0
        
        for food in filteredFoods {
            for ingredient in food.ingredients{
                total += ingredient.totalNutritions["kcal"] ?? 0
            }
        }
        
        return total
    }
    func totalCal(for food:Food)->Int{
        var total = 0
        
        for ingred in food.ingredients{
            total += ingred.totalNutritions["kcal"] ?? 0
        }
        return total
    }
}

struct MealItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        MealItem(foods: [Food(name: "Baked sweet potato with salmon and grilled vegetables", meal: "Dinner", ingredients: [Ingredients]()),Food(name: "Baked sweet potato with salmon and grilled vegetables", meal: "Dinner", ingredients: [Ingredients]()),Food(name: "Baked sweet potato with salmon and grilled vegetables", meal: "Dinner", ingredients: [Ingredients]()),Food(name: "Baked sweet potato with salmon and grilled vegetables", meal: "Dinner", ingredients: [Ingredients]()),Food(name: "Baked sweet potato with salmon and grilled vegetables", meal: "Dinner", ingredients: [Ingredients]())], meal: "Dinner",color: Color.openGreen, nameSpace:  namespace){_ in
            
        }
    }
}
