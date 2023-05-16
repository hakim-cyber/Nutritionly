//
//  NutritionsLine.swift
//  Nutritionly
//
//  Created by aplle on 5/17/23.
//

import SwiftUI

struct NutritionsLine: View {
    @State private var screen = UIScreen.main.bounds
    @EnvironmentObject var dataManager:NutritionData_Manager
    var body: some View {
        ZStack{
            HStack(alignment: .center,spacing:25){
                ForEach(dataManager.nutritionsArray,id:\.self){ nutrit in
                    VStack(spacing: 5){
                        Text(nutrit.name)
                            .fontDesign(.monospaced)
                        Text("\(nutrit.count)\(nutrit.shortName)")
                            .fontWeight(.heavy)
                            .fontDesign(.default)
                        
                    }
                }
            }
        }
        .frame(maxWidth: screen.width/1.05)
    }
}

struct NutritionsLine_Previews: PreviewProvider {
    static var previews: some View {
        NutritionsLine()
            .environmentObject(NutritionData_Manager())
        
    }
}
