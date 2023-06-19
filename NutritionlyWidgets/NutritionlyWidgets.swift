//
//  NutritionlyWidgets.swift
//  NutritionlyWidgets
//
//  Created by aplle on 6/19/23.
//

import WidgetKit
import SwiftUI
import Intents







struct NutritionlyWidgets: Widget {
    let kind: String = "NutritionlyWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NutritionlyWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
        
    }
}


