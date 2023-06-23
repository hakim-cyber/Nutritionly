//
//  TimelineEntry.swift
//  NutritionlyWidgetsExtension
//
//  Created by aplle on 6/19/23.
//

import WidgetKit
import Intents


struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    var nutritions:[String:Int]?
    var nutritionNeed:[String:Int]?
    var color:String?
}
