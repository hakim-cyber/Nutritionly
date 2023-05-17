//
//  NewFoodView.swift
//  Nutritionly
//
//  Created by aplle on 5/17/23.
//

import SwiftUI

struct NewFoodView: View {
    var meal:String
    var color:Color
    @State var name = ""
    @State var typeOfadding = TypeOfAddings.new
    @EnvironmentObject var dataManager:NutritionData_Manager
    @State private var ingredients = [Ingredients(title: "name", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "ame", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "hame", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "nme", calorie: 0, protein: 0, fat: 0, carbs: 0)]
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            VStack(spacing: 25){
                CustomSwitch(typeOfadding: $typeOfadding)
                if typeOfadding == .new{
                    new
                }else{
                    
                }
                Spacer()
                
            }
            .padding(.top)
        }
       
    }
    
    var new:some View{
        VStack(spacing: 20){
            VStack{
                TextField("Name",text: $name)
                .background( Color.clear)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color:.gray,radius: 5)
                .padding(.horizontal,10)
               
                    Rectangle()
                    .fill(.gray)
                    .frame(width: 350, height: 4)
                    .opacity(0.2)
            }
          
            HStack{
                Text("Ingredients")
                    .foregroundColor(.primary)
                    .font(.system(size: 23))
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                  
                Button{
                    
                }label: {
                    Image(systemName: "plus")
                        .font(.caption)
                        .padding(5)
                        .background(Circle().stroke(.gray))
                }
                Spacer()
                
            }
           
            ScrollView(.vertical,showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach(ingredients, id: \.title){ingred in
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
            
               
        }
        .padding(.horizontal,20)
        
    }
}

struct NewFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NewFoodView(meal: "Breakfast",color: Color.indigo)
    }
}

