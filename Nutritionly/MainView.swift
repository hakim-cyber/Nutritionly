//
//  MainView.swift
//  Nutritionly
//
//  Created by aplle on 5/14/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataManager: NutritionData_Manager
    @State var screen = UIScreen.main.bounds
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(.white)
                        .padding(.horizontal,10)
                        .shadow(color: .black,radius: 10)
                }
                 .frame(width: screen.width / 1.1,height:200 )
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NutritionData_Manager())
    }
}
