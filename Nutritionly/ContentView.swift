//
//  ContentView.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    init(){
        UITabBar.appearance().isHidden = true
    }
    @State var showTabBar = true
    @State private var selectedTab:Tab = .house
    
    @AppStorage("backgroundColor") var backgroundColor = Colors.openGreen.rawValue
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab){
                ForEach(Tab.allCases , id:\.rawValue){tab in
                    
                    if tab == .house{
                        MainView(){
                            withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.6)){
                                showTabBar.toggle()
                            }
                        }
                              
                              .tag(tab)
                              .transition(.move(edge: .trailing))
                            }
                    
                    if tab == .chart{
                      
                      StatsView()
                            .tag(tab)
                            .transition(.move(edge: .trailing))
                            
                    }
                    if tab == .person{
                       ProfileView()
                            .tag(tab)
                            .transition(.move(edge: .trailing))
                            
                    }
                }
            }
           
            VStack{
               Spacer()
                Spacer()
                if showTabBar{
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
                
                
        }
        

    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserStore())
            .environmentObject(NutritionData_Manager())
    }
}
