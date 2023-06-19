//
//  SearchIngredientsView.swift
//  Nutritionly
//
//  Created by aplle on 5/18/23.
//

import SwiftUI

struct SearchIngredientsView: View {
    var color:Color
    var select:([Ingredients])-> Void
    
@StateObject var model = SearchIngredientViewModel()
    
    
    
    
  
    @State private var selectedIngredients = [Ingredients]()
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            VStack(spacing: 30){
                CustomSearchBar(searchText: $model.serchText, color:color){
                    Task{
                          await model.searchForIngred()
                    }
                }
                if !model.searchResults.isEmpty{
                    ScrollView(.vertical,showsIndicators: false){
                        LazyVStack(spacing: 10){
                            ForEach(searchResult ,id:\.id){ingred in
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
                                .padding(.top)
                                .padding(.horizontal,10)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        if isSelected(ingred: ingred){
                                            if let index = selectedIngredients.firstIndex(where: {$0.fdcId == ingred.fdcId}){
                                                selectedIngredients.remove(at: index)
                                            }
                                        }else{
                                            selectedIngredients.append(ingred)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }else{
                    
                }
            }
           
            .padding(.top,30)
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom){
            Button{
                withAnimation{
                    select(selectedIngredients)
                }
            }label:{
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.black)
                     
                    Text(textButtonAdding())
                        .font(.system(size: 20))
                        .fontDesign(.monospaced)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                }
                .frame(width: screen.width / 1.08,height: 60)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                       
                   // Give a moment for the screen boundaries to change after
                   // the device is rotated
                   Task { @MainActor in
                       try await Task.sleep(for: .seconds(0.001))
                       withAnimation{
                           self.screen = UIScreen.main.bounds
                       }
                   }
               }
        .onAppear{
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.001))
                withAnimation{
                    self.screen = UIScreen.main.bounds
                }
            }
        }
       
    }
    
    
    func isSelected(ingred:Ingredients)->Bool{
        return selectedIngredients.contains(where: {$0.fdcId == ingred.fdcId})
    }
    var searchResult:[Ingredients]{
        var results = [Ingredients]()
        for result in model.searchResults {
            let proteins = Int(filterNutrition(nutritions: result.filteredNutrients, nutrition: "protein").value)
            let kcal = Int( filterNutrition(nutritions: result.filteredNutrients, nutrition: "kcal").value)
            let fat = Int(filterNutrition(nutritions: result.filteredNutrients, nutrition: "fat").value)
            let carb = Int( filterNutrition(nutritions: result.filteredNutrients, nutrition: "carb").value)
            
            let ingredient = Ingredients(id:UUID(),fdcId: result.fdcId ?? 0, title: result.description ?? "", calorie: kcal, protein: proteins, fat: fat, carbs: carb)
            
            results.append(ingredient)
        }
        return results
    }
    /*
     kcal (208), protein (203), carbs (205), and fats (204)
     */
    func filterNutrition(nutritions:[NutritionInfo],nutrition:String)->NutritionInfo{
        if nutrition == "protein"{
           
            if nutritions.filter({$0.nutrientNumber == "203"}).count > 0{
                return nutritions.filter{$0.nutrientNumber == "203"}.first!
            }
        }else if nutrition == "carb"{
            if  nutritions.filter({$0.nutrientNumber == "205"}).count > 0 {
                return  nutritions.filter{$0.nutrientNumber == "205"}.first!
            }
        }else if nutrition == "fat"{
            if nutritions.filter({$0.nutrientNumber == "204"}).count > 0{
                return    nutritions.filter{$0.nutrientNumber == "204"}.first!
            }
           
        }else{
            if nutritions.filter({$0.nutrientNumber == "208"}).count > 0{
                return nutritions.filter{$0.nutrientNumber == "208"}.first!
            }
        }
        return NutritionInfo(nutrientId: 0, nutrientNumber: "", nutrientName: "non", value: 0, unitName: "nil")
      
    }
    
    func textButtonAdding()->String{
        
            if selectedIngredients.isEmpty{
                return String("add")
            }else if selectedIngredients.count == 1{
                return String("add 1 ingredient")
            }else{
                return String("add \(selectedIngredients.count) ingredients")
            }
        
    }
}

struct SearchIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientsView(color:Color.openGreen){_ in
            
        }
    }
}
