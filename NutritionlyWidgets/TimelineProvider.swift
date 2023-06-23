//
//  TimelineProvider.swift
//  NutritionlyWidgetsExtension
//
//  Created by aplle on 6/19/23.
//

import WidgetKit
import Intents


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(),nutritions: nil,nutritionNeed: nil,color: nil)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        getNutritions(date: Date(), configuration: configuration, completion: completion)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        print("load")
        createTimeline(date: Date(), configuration: configuration, completion: completion)
    }
    func getNutritions(date:Date,configuration:ConfigurationIntent,completion: @escaping (SimpleEntry) -> ()){
        var entry = SimpleEntry(date: date, configuration: configuration)
        if let data = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly")?.data(forKey: "nutritOfDay"){
            if let decoded = try? JSONDecoder().decode([String:Int].self, from: data){
               
                entry.nutritions = decoded
                
            }
        }
        if let data = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly")?.data(forKey: "nutritNeed"){
            if let decoded = try? JSONDecoder().decode([String:Int].self, from: data){
               
                entry.nutritionNeed = decoded
                print("loaded")
               
            }
        }
        if let data = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly")?.data(forKey: "backgroundColor"){
            if let decoded = try? JSONDecoder().decode(String.self, from: data){
               
                entry.color = decoded
                
               
               
            }else{
                print("error decoding")
            }
        }else{
            print("error fetching data")
        }
        
        completion(entry)
    }
    func createTimeline(date:Date,configuration:ConfigurationIntent,completion: @escaping (Timeline<SimpleEntry>) -> ()){
        
        var entry = SimpleEntry(date: date, configuration: configuration)
        if let data = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly")?.data(forKey: "nutritOfDay"){
            if let decoded = try? JSONDecoder().decode([String:Int].self, from: data){
             
                entry.nutritions = decoded
            }
        }else{
            print("eroor")
        }
        if let data = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly")?.data(forKey: "nutritNeed"){
            if let decoded = try? JSONDecoder().decode([String:Int].self, from: data){
               
                entry.nutritionNeed = decoded
            }
        }
        if let data = UserDefaults(suiteName: "group.me.hakim.Aliyev.Nutritionly")?.data(forKey: "backgroundColor"){
            if let decoded = try? JSONDecoder().decode(String.self, from: data){
               
                entry.color = decoded
                
               
               
            }else{
                print("error decoding")
            }
        }else{
            print("error fetching data")
        }
        let timeline = Timeline(entries:[entry], policy: .atEnd)
                       completion(timeline)
    }
}
