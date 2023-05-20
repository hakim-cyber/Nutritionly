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
    @State private var ingredients = [Ingredients]()
    var namespace:Namespace.ID
    var close:()->Void
    
    @State private var showsearchView = false
    @State private var showtotalView = false
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            if !showsearchView{
                if !showtotalView{
                    ZStack{
                        color.ignoresSafeArea()
                            .matchedGeometryEffect(id: "Background\(meal)", in: namespace)
                        VStack(spacing: 25){
                            HStack{
                                Image(systemName: "arrow.backward")
                                    .onTapGesture {
                                        close()
                                    }
                                Spacer()
                            }
                            .padding(.horizontal)
                            CustomSwitch(typeOfadding: $typeOfadding)
                            if typeOfadding == .new{
                                new
                            }else{
                                
                            }
                            Spacer()
                            
                        }
                        .padding(.top)
                    }
                    .safeAreaInset(edge: .bottom){
                        Button{
                            // Go to total view
                            withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                showtotalView = true
                            }
                            
                        }label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(.black)
                                
                                Text("add food")
                                    .font(.system(size: 20))
                                    .fontDesign(.monospaced)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                
                            }
                            .frame(width: screen.width / 1.08,height: 60)
                        }
                    }
                    .transition(.move(edge: .top))
                }else{
                    TotalFoodView(ingredients: $ingredients, name: name, meal: meal){
                        dataManager.AddNewFoodForDay(ingred: ingredients, name: name, meal: meal)
                        close()
                    }
                        .transition(.move(edge: .top))
                }
                
            }else{
                SearchIngredientsView(color: color){selected in
                    withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                        for select in selected{
                            if !ingredients.contains(where: {$0.id == select.id}){
                                ingredients.append(select)
                            }
                        }
                        showsearchView = false
                        
                    }
                }
                .transition(.move(edge: .bottom))
            }
            
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
                    withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                        showsearchView = true
                    }
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
            
               
        }
        .padding(.horizontal,20)
        
        
    }
    
}

struct NewFoodView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NewFoodView(meal: "Breakfast",color: Color.indigo,namespace: namespace){
            
        }
    }
}

