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
    
    @State private var allData = [Ingredients(title: "name", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "ame", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "hame", calorie: 0, protein: 0, fat: 0, carbs: 0),Ingredients(title: "nme", calorie: 0, protein: 0, fat: 0, carbs: 0)]
    @State private var selectedIngredients = [Ingredients]()
    @State private var searchText = ""
    
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            VStack(spacing: 30){
                CustomSearchBar(searchText: $searchText, color:color)
                ScrollView(.vertical,showsIndicators: false){
                    LazyVStack(spacing: 0){
                        ForEach(filteredData, id: \.id){ingred in
                            HStack{
                                CustomCheckMark(selected: isSelected(ingred: ingred), size: 23)
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
                                    .padding(.leading,1)
                                    .padding(.horizontal,5)
                                    .padding(5)
                                }
                                
                                
                            }
                            .padding(.top)
                            .padding(.horizontal,10)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)) {
                                    if isSelected(ingred: ingred){
                                        if let index = selectedIngredients.firstIndex(where: {$0.id == ingred.id}){
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
       
    }
    var filteredData:[Ingredients]{
        if searchText != ""{
            return allData.filter{$0.title.localizedCaseInsensitiveContains(searchText)}
        }else{
            return allData
        }
    }
    
    func isSelected(ingred:Ingredients)->Bool{
       return selectedIngredients.contains(where: {$0.id == ingred.id})
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
