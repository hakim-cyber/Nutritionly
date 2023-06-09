//
//  CustomTabBar.swift
//  Nutritionly
//
//  Created by aplle on 5/25/23.
//

import SwiftUI

enum Tab:String,CaseIterable{
    case house
    case chart
    case person
}

struct CustomTabBar: View {
    @Binding var selectedTab:Tab
    private var fillImage:String{
        if selectedTab != .chart{
           return selectedTab.rawValue + ".fill"
        }else{
           return selectedTab.rawValue + ".bar.fill"
        }
    }
    
    @State private var screen = UIScreen.main.bounds
    @State private var animate = false
    @Namespace var namespace
    var body: some View {
        VStack{
           
            HStack{
                ForEach(Tab.allCases,id:\.rawValue){tab in
                    Spacer()
                    ZStack{
                       
                        VStack(alignment: .center){
                            Image(systemName: selectedTab == tab ? fillImage : imageTab(tab: tab))
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .onTapGesture{
                                    withAnimation(.easeInOut(duration: 0.3)){
                                        selectedTab = tab
                                    }
                                }
                            if selectedTab == tab{
                                
                            Text(textTab(tab:tab))
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                
                            }
                     
                        }
                        
                        
                      
                       
                    }
                    Spacer()
                    
                }
                
            }
            .frame(height: 72)
            .frame(maxWidth: screen.width/1.5)
            .background(Color.black)
            .cornerRadius(40)
            .padding(.horizontal,10)
           
          
           
        }
        .ignoresSafeArea()
    }
    func imageTab(tab:Tab)->String{
        if tab != .chart{
            return tab.rawValue
        }else{
            return tab.rawValue + ".bar"
        }
    }
    func textTab(tab:Tab)->String{
        switch tab{
        case.chart:
            return "Stats"
        case .house:
            return "Main"
        case .person:
            return "Profile"
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(Tab.house))
    }
}


