//
//  TotalFoodView.swift
//  Nutritionly
//
//  Created by aplle on 5/19/23.
//

import SwiftUI

struct TotalFoodView: View {
   @Binding var ingredients:[Ingredients]
    var name:String
    var meal:String
    var close:()->Void
    
    @State var tappedIngreds = [Ingredients]()
    @FocusState private var amountIsFocused: Bool
    
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
                        ForEach(Array(ingredients.indices), id: \.self){index in
                            ZStack{
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .shadow(radius: 5)
                                    .opacity(0.7)
                                VStack{
                                    VStack{
                                        HStack{
                                            Text(ingredients[index].title)
                                            Spacer()
                                            Text("\(ingredients[index].grams)g")
                                                .fontDesign(.rounded)
                                                .font(.callout)
                                                .foregroundColor(.gray)
                                            
                                            
                                        }
                                        
                                        HStack{
                                            
                                            Text("p")
                                                .foregroundColor(.secondary)
                                            Text("\(ingredients[index].totalNutritions["p"] ?? 0)g")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.bold)
                                            Text("c")
                                                .foregroundColor(.secondary)
                                            Text("\(ingredients[index].totalNutritions["c"] ?? 0)g")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.bold)
                                            Text("f")
                                                .foregroundColor(.secondary)
                                            Text("\(ingredients[index].totalNutritions["f"] ?? 0)g")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.bold)
                                            
                                            Text("\(ingredients[index].totalNutritions["kcal"] ?? 0)kcal")
                                                .fontDesign(.monospaced)
                                                .fontWeight(.bold)
                                            
                                            
                                        }
                                        
                                    }
                                    .onTapGesture{
                                        withAnimation(.easeInOut){
                                            if tappedIngreds.contains(where:{$0.id == ingredients[index].id}){
                                                if  let index = tappedIngreds.firstIndex(where: {$0.id == ingredients[index].id}){
                                                    tappedIngreds.remove(at: index)
                                                }
                                            }else{
                                                tappedIngreds.append(ingredients[index])
                                            }
                                        }
                                    }
                                    // foods grams changing
                                    
                                    if tappedIngreds.contains(where:{$0.id == ingredients[index].id}){
                                        TextField("amount in grams", value: $ingredients[index].grams, formatter: NumberFormatter())
                                            .keyboardType(.numberPad)
                                            .focused($amountIsFocused)
                                            .padding(8)
                                            .padding(.horizontal,5)
                                            .background(.thinMaterial)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                            .shadow(color:.gray,radius: 5)
                                            .padding(.horizontal,5)
                                            .padding(.vertical,2)
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
                .scrollDismissesKeyboard(.immediately)
                .ignoresSafeArea(.keyboard)
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
                                .fontDesign(.rounded)
                                .fontWeight(.black)
                        }
                        .font(.system(size: 20))
                    }
                    .padding()
                }
                .frame( height: screen.height / 5.5)
                .padding(.horizontal)
                
                Spacer()
                
            }
            .padding(.top)
            .padding(.horizontal)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                   
                        Spacer()
                     
                            Button("Done") {
                                amountIsFocused = false
                            }
                        
                    }
                    
                
            }
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
        .ignoresSafeArea(.keyboard)
     
    }
    var totals:[String:Int]{
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

struct TotalFoodView_Previews: PreviewProvider {
    @State private static var ingredients = [Ingredients(id:UUID(),fdcId: 0, title: "name", calorie: 0, protein: 0, fat: 0, carbs: 0)]
    static var previews: some View {
        TotalFoodView(ingredients:.constant(ingredients), name: "Pasta", meal: "Dinner"){
            
        }
    }
}
