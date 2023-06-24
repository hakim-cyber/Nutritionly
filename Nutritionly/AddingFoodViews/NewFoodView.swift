//
//  NewFoodView.swift
//  Nutritionly
//
//  Created by aplle on 5/17/23.
//

import SwiftUI
import EmojiPicker

struct NewFoodView: View {
    var meal:String
    var color:Color
    @State var name = ""
    @State var typeOfadding = TypeOfAddings.new
    @EnvironmentObject var dataManager:NutritionData_Manager
    @EnvironmentObject var userStore:UserStore
    @State private var ingredients = [Ingredients]()
   
    
    @State private var selectedFood:Food?
    // emoji picker
    @State private var selectedEmoji:Emoji?
    @State private var showEmojiPikcer = false
    
    var namespace:Namespace.ID
    var close:()->Void
    
    @State private var showsearchView = false
    @State private var showManualAddview = false
 
    @State private var showtotalView = false
    @State private var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            if !showsearchView && !showManualAddview{
       
                if !showtotalView{
                    ZStack{
                        color.ignoresSafeArea()
                            .matchedGeometryEffect(id: "Background\(meal)", in: namespace)
                        VStack(spacing: 25){
                            HStack{
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        close()
                                    }
                                Spacer()
                            }
                            .padding(.horizontal)
                            CustomSwitch(typeOfadding: $typeOfadding)
                            if typeOfadding == .new{
                                new
                                    .transition(.move(edge: .leading))
                            }else{
                                // recents view
                                RecentsView(selectedFood: $selectedFood)
                                    .transition(.move(edge: .trailing))
                                
                            }
                            Spacer()
                            
                        }
                        .padding(.top)
                    }
                    .safeAreaInset(edge: .bottom){
                        Button{
                            // Go to total view
                            if typeOfadding == .new{
                                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                    showtotalView = true
                                }
                            }else{
                                
                                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                    if let selectedFood = selectedFood{
                                        dataManager.AddNewFoodForDay(ingred: selectedFood.ingredients, name: selectedFood.name, meal: meal,emoji: selectedFood.emoji)
                                    }
                                    close()
                                  
                                }
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
                }else{
                    
                    TotalFoodView(ingredients: $ingredients, name: name, meal: meal){
                        
                        dataManager.AddNewFoodForDay(ingred: ingredients, name: name, meal: meal,emoji: selectedEmoji?.value)
                        close()
                       
                    }
                    .transition(.move(edge: .top))
                    
                }
                
              
            }else{
                if showManualAddview{
                    ManualIngredAdding(color: color){selected in
                        withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                            for select in selected{
                                if !ingredients.contains(where: {$0.id == select.id}){
                                    ingredients.append(select)
                                }
                            }
                            showManualAddview = false
                            
                        }
                    }
                    .transition(.move(edge: .bottom))
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
    }
    
    var new:some View{
        
        VStack(spacing: 20){
            VStack{
                HStack{
           
                        TextField("Name",text: $name)
                            .background( Color.clear)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color:.gray,radius: 5)
                            .padding(.horizontal,10)
                            .colorScheme(.light)
                        
                    
                    
                    Text("\(selectedEmoji?.value ?? "📸")")
                        .foregroundColor(.white)
                        .onTapGesture {
                            showEmojiPikcer = true
                        }
                        .font(.title)
                }
                Rectangle()
                    .fill(.gray)
                    .frame(width: 350, height: 4)
                    .opacity(0.2)
                    
                   
                
            }
          
            HStack{
                Text("Ingredients")
                    .foregroundColor(.white)
                    .font(.system(size: 23))
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                  
         
                    Menu{
                        Button{
                            withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                showManualAddview = true
                            }
                        }label: {
                            Text("Add Manual")
                            Image(systemName: "hand.draw.fill")
                        }
                        Button{
                            if userStore.userIsPro{
                                withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                    showsearchView = true
                                }
                            }else{
                                withAnimation(.easeInOut){
                                                userStore.showPurchaseView = true
                                            }
                            }
                        }label: {
                           
                            if userStore.userIsPro{
                                Text("Search Database")
                                Image(systemName: "magnifyingglass")
                            }else{
                                Text("Search Database (Pro)")
                                Image(systemName: "checkmark.seal.fill")
                                  .foregroundColor(Color("openBlue"))
                                  .font(.title3)
                            }
                        }
                       
                       
                    
                   
                }label: {
                    Image(systemName: "plus")
                        .font(.caption)
                        .foregroundColor(.white)
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
                                        .foregroundColor(.black)
                                    Spacer()
                                   
                                }
                                
                                    HStack{
                                        
                                        Text("p")
                                            .foregroundColor(.secondary)
                                        Text("\(ingred.protein)g")
                                       
                                            .fontDesign(.monospaced)
                                            .fontWeight(.bold)
                                        Text("c")
                                          
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
        .sheet(isPresented: $showEmojiPikcer){
            EmojiPickerView(selectedEmoji: $selectedEmoji)
                .background(color.ignoresSafeArea())
        }
        
        
    }
    
   

    
}

struct NewFoodView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NewFoodView(meal: "Breakfast",color: Color.indigo,namespace: namespace){
            
        }
        .environmentObject(UserStore())
    }
}

