//
//  WidgetsView.swift
//  NutritionlyWidgetsExtension
//
//  Created by aplle on 6/19/23.
//

import SwiftUI
import WidgetKit


struct NutritionlyWidgetsEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack{
           
            if  entry.color != nil{
                Color(entry.color!)
            }else{
                Color.openGreen
            }
            
            HStack{
                if widgetFamily == .systemMedium{
                    VStack(alignment: .leading, spacing: 15){
                        Text("today")
                            .font(.system(size: 40))
                            .fontDesign(.monospaced)
                            .fontWeight(.heavy)
                            .font(.system(size: 1000))
                            .minimumScaleFactor(0.001)
                        
                        
                        HStack{
                            Text("\(entry.nutritions?["kcal"] ?? 0)/\(entry.nutritionNeed?["kcal"] ?? 0)")
                                .fontDesign(.monospaced)
                                .fontWeight(.bold)
                                .font(.system(size: 500))
                                .minimumScaleFactor(0.03)
                            
                            Text("kcal")
                                .foregroundColor(.secondary)
                                .font(.system(size: 600))
                                .minimumScaleFactor(0.001)
                        }
                        
                        HStack{
                            
                            Text("p")
                                .foregroundColor(.secondary)
                            
                            Text("\(entry.nutritions?["p"] ?? 0 ) g")
                                .fontWeight(.bold)
                            
                            
                            Text("c")
                                .foregroundColor(.secondary)
                            
                            Text("\(entry.nutritions?["c"] ?? 0) g")
                            
                                .fontWeight(.bold)
                            
                            Text("f")
                            
                                .foregroundColor(.secondary)
                            Text("\(entry.nutritions?["f"] ?? 0) g")
                                .fontWeight(.bold)
                            
                            
                        }
                        .font(.system(size: 600))
                        .minimumScaleFactor(0.02)
                        
                        Spacer()
                        
                        
                    }
                    Spacer()
                    CustomProgressView(progress:progressCalories )
                }else if widgetFamily == .systemSmall  {
                    VStack{
                        CustomProgressView(progress:progressCalories )
                        Text("\(entry.nutritions?["kcal"] ?? 0) Kcal")
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                        
                    }
                 
                    
                }else if widgetFamily == .systemLarge{
                    
                }
                                                
                                               
                                              
                  
                                            }
                                            .padding(20)
                                            
          
        }
        
        
    }
    
    var progressCalories:Double{
        Double( entry.nutritions?["kcal"] ?? 0) /  Double( entry.nutritionNeed?["kcal"] ?? 0 )
    }
  
}

struct NutritionlyWidgets_Previews: PreviewProvider {
    static var previews: some View {
        NutritionlyWidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), nutritions: [
            "kcal":500,
            "p":100,
            "c":7000,
            "f":4500,
        
        
        ],nutritionNeed: [
            "kcal":1600,
            "p":100,
            "c":150,
            "f":70,
        
        
        ]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
