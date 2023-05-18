//
//  TotalFoodView.swift
//  Nutritionly
//
//  Created by aplle on 5/19/23.
//

import SwiftUI

struct TotalFoodView: View {
    var ingredients:[Ingredients]
    var name:String
    var meal:String
    var close:()->Void
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
           
            
            VStack{
                HStack{
                    Spacer()
                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 23))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    Spacer()
                    Button{
                        withAnimation{
                            
                            close()
                        }
                    }label: {
                       
                        Image(systemName: "plus")
                            .font(.title3)
                            .padding(5)
                            .background(Circle().stroke(.gray))
                            .shadow(radius: 10)
                    }
                }
                
                ScrollView(.vertical,showsIndicators: false){
                                LazyVStack(spacing: 0){
                                    ForEach(ingredients, id: \.id){ingred in
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                                .fill(.ultraThinMaterial)
                                                .shadow(radius: 5)
                                                .opacity(0.7)
                                              
                                            VStack{
                                                HStack{
                                                    Text(ingred.title)
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
                                            .padding(.leading)
                                            .padding(.horizontal,5)
                                            .padding(5)
                                        }
                                        .padding(.top)
                                        .padding(.horizontal)
                                        
                                    }
                                }
                            }
                // total card view
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.thinMaterial)
                       
                    
                    VStack{
                        HStack{
                            Text("Total")
                                .foregroundColor(.black)
                                .font(.system(size: 35))
                                .fontDesign(.rounded)
                                .fontWeight(.bold)
                         
                        }
                      Spacer()
                        HStack{
                            
                            Text("p")
                                .foregroundColor(.secondary)
                            Text("\(totals["p"] ?? 0)g")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                            Text("c")
                                .foregroundColor(.secondary)
                            Text("\(totals["c"] ?? 0)g")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                            Text("f")
                                .foregroundColor(.secondary)
                            Text("\(totals["f"] ?? 0)g")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                            
                            Text("\(totals["kcal"] ?? 0)kcal")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 25))
                    }
                    .padding()
                }
                .frame( height: screen.height / 5.5)
                .padding(.horizontal)
                
                Spacer()
               
            }
            .padding(.top)
            .padding(.horizontal)
        }
     
    }
    var totals:[String:Int]{
      var totalProtein = 0
      var totalCarb = 0
      var totalKcal = 0
    var totalFats = 0
        
        for ingredient in ingredients {
            totalProtein += ingredient.protein
            totalCarb += ingredient.carbs
            totalKcal += ingredient.calorie
            totalFats += ingredient.fat
            
        }
        
        return [
        "p":totalProtein,
        "c":totalCarb,
        "f":totalFats,
        "kcal":totalKcal
        
        ]
    }
}

struct TotalFoodView_Previews: PreviewProvider {
    @State private static var ingredients = [Ingredients(title: "name", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "ame", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "hame", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "nme", calorie: 0, protein: 0, fat: 0, carbs: 0)]
    static var previews: some View {
        TotalFoodView(ingredients:ingredients, name: "Pasta", meal: "Dinner"){
            
        }
    }
}
