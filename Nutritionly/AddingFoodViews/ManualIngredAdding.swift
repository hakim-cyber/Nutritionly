//
//  ManualIngredAdding.swift
//  Nutritionly
//
//  Created by aplle on 6/22/23.
//

import SwiftUI

struct ManualIngredAdding: View {
    let color:Color
    var select:([Ingredients])-> Void
    
    @State private var title = ""
    @State private var serviceSize = 0
    @State private var kcal = 0
    @State private var protein = 0
    @State private var carb = 0
    @State private var fat = 0
    
    
    @State private var screen = UIScreen.main.bounds
    
    @EnvironmentObject var datamanager:NutritionData_Manager
    var body: some View {
        ZStack{
            color.ignoresSafeArea()
            VStack(spacing: 30){
                HStack{
                    Button{
                        select([])
                    }label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                    }
                   
                Spacer()
                }
                HStack{
                    Spacer()
                    TextField("Title",text: $title)
                        .font(.system(size: 20))
                        .fontDesign(.monospaced)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                HStack{
                    ZStack{
                        // servingSize
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.regularMaterial)
                        
                        VStack(alignment: .leading){
                           Text("Serving Size (g)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.11)
                                .scaledToFit()
                                .padding(15)
                           
                                Picker("",selection: $serviceSize){
                                    ForEach(0...1000,id:\.self){
                                        Text("\($0)")
                                            .foregroundColor(.black)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            
                        }
                       
                      
                        
                        
                    }
                    .frame(width: screen.width / 2.3,height: screen.height / 5)
                    ZStack{
                        //calorie per 100 gram
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.regularMaterial)
                        
                        VStack(alignment: .leading){
                           Text("Calorie (100g)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.11)
                                .scaledToFit()
                                .padding(15)
                           
                                Picker("",selection: $kcal){
                                    ForEach(0...1500,id:\.self){
                                        Text("\($0)")
                                            .foregroundColor(.black)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            
                        }
                    }
                    .frame(width: screen.width / 2.3,height: screen.height / 5)
                }
               
                HStack{
                   
                    Text("Nutrition")
                        .font(.system(size: 20))
                        .fontDesign(.monospaced)
                        .fontWeight(.heavy)
                        .foregroundColor(.secondary.opacity(0.6))
                    
                    Spacer()
                }
              HStack {
                    ZStack{
                        // carbs
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.yellow.gradient)
                           
                        VStack(alignment: .leading){
                           Text("Carbs (100g)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.11)
                                .scaledToFit()
                                .padding(15)
                           
                                Picker("",selection: $carb){
                                    ForEach(0...500,id:\.self){
                                        Text("\($0)")
                                            .foregroundColor(.white)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            
                        }
                    }
                    .frame(width: screen.width / 3.3,height: screen.height / 5)
                    ZStack{
                        //fats
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.pink.gradient)
                          
                        VStack(alignment: .leading){
                           Text("Fats (100g)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.11)
                                .scaledToFit()
                                .padding(15)
                           
                                Picker("",selection: $fat){
                                    ForEach(0...450,id:\.self){
                                        Text("\($0)")
                                            .foregroundColor(.white)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            
                        }
                       
                    }
                    .frame(width: screen.width / 3.3,height: screen.height / 5)
                    ZStack{
                        //protein
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.mint.gradient)
                            
                        VStack(alignment: .leading){
                           Text("Protein (100g)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.11)
                                .scaledToFit()
                                .padding(15)
                           
                                Picker("",selection: $protein){
                                    ForEach(0...500,id:\.self){
                                        Text("\($0)")
                                            .foregroundColor(.white)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.wheel)
                                
                            
                        }
                       
                    }
                    .frame(width: screen.width / 3.3,height: screen.height / 5)
                
                }
                HStack{
                    Text("Daily Goals")
                        .font(.system(size: 16))
                        .fontDesign(.monospaced)
                        .fontWeight(.heavy)
                        .foregroundColor(.secondary.opacity(0.6))
                    Spacer()
                }
                HStack(spacing: 15){
                    VStack{
                        ProgressView(value: Double(kcal) * (Double(serviceSize) / 100),total: Double(datamanager.caloriesNeed))
                            .frame(width: screen.width / 5)
                            
                            .cornerRadius(30)
                        Text("\(calculatePercent(value:kcal , from:datamanager.caloriesNeed))% KCAL")
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                           
                           
                    }
                    VStack{
                        ProgressView(value: Double(carb) * (Double(serviceSize) / 100),total: Double(datamanager.carbohydratesNeed))
                            .frame(width: screen.width / 5)
                            .tint(.yellow)
                           
                        Text("\(calculatePercent(value:carb , from:datamanager.carbohydratesNeed) )% CARBS")
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                           
                            .font(.system(size: 14))
                    }
                        VStack{
                            ProgressView(value: Double(fat) * (Double(serviceSize) / 100),total: Double(datamanager.fatsNeed))
                                .frame(width: screen.width / 5)
                                .tint(.pink)
                             
                            Text("\(calculatePercent(value:fat , from:datamanager.fatsNeed) )% FAT")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                               
                                .font(.system(size: 14))
                        }
                            VStack{
                                ProgressView(value: Double(protein) * (Double(serviceSize) / 100),total: Double(datamanager.proteinNeed))
                                    .frame(width: screen.width / 5)
                                    .tint(.mint)
                                   
                                Text("\(calculatePercent(value:protein , from:datamanager.proteinNeed))% PROTEIN")
                                    .fontDesign(.monospaced)
                                    .fontWeight(.bold)
                                    .foregroundColor(.mint)
                                   
                                    .font(.system(size: 14))
                            }
                    
                   
                    
                }
                .padding(.top)
              
                
               
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding(.horizontal)
            .padding(.top)
            .safeAreaInset(edge: .bottom, content: {
                Button{
                // save
                    select([ingredient])
            }label:{
                Text("Save")
                .padding(.horizontal,30)
                .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(30)
            .disabled(
            serviceSize == 0 || kcal == 0 || protein == 0 || carb == 0 || fat == 0 || title == ""
            )
                
            })
        }
        .preferredColorScheme(.light)
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
    var ingredient:Ingredients{
        Ingredients(grams:serviceSize,id: UUID(), fdcId: 0, title: title, calorie: kcal, protein: protein, fat: fat, carbs: carb)
    }
    func calculatePercent(value:Int,from:Int)->Int{
         
        let valueTotal = Double(value) *  (Double(serviceSize) / 100)
        
        let percent = (valueTotal / Double(from)) * 100
        
        return Int(percent.rounded())
        
        
    }
    
}

struct ManualIngredAdding_Previews: PreviewProvider {
    static var previews: some View {
        ManualIngredAdding(color: Color.openGreen){_ in
            
        }
        .environmentObject(NutritionData_Manager())
    }
}
