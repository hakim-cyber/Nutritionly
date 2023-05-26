//
//  StatsView.swift
//  Nutritionly
//
//  Created by aplle on 5/26/23.
//

import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var userstore:UserStore
    
@State private var currentTab = "Kcal"
    
    @State private var statsItems = [StatsItem]()
    let tabs = ["Kcal","🏋️ Workout","⚖️ Weight","💧 Water"]
    @State var currentActive:StatsItem?
    @State var plotWidth:CGFloat = 0
    @State var isLineGraph = false
    @Namespace var nameSpace
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    //
                    VStack(alignment: .leading){
                        HStack{
                            Picker("",selection: $currentTab){
                                ForEach(tabs,id:\.self){tab in
                                    Text("\(tab)")
                                        .tag(tab)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.bottom)
                        }
                        
                        AnimatedChart()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10,style: .continuous).fill(.white.shadow(.drop(radius: 2))))
                    
                    Toggle("Line Graph",isOn: $isLineGraph)
                        .padding(.top)
                 
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .padding()
                entitiesList()
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .onAppear(perform: refreshStatsItems)
            .onChange(of: currentTab){_ in
                refreshStatsItems()
                animateGraph(fromChange: true)
            }
            .background(BackGround(namespace: nameSpace))
          
            
        }
    }
    @ViewBuilder
    func AnimatedChart()->some View{
        let max = statsItems.max{item1,item2 in
            return item2.value > item1.value
        }?.value ?? 0
        
        Chart{
            ForEach(statsItems){item in
                if isLineGraph{
                    
                        LineMark(
                            x: .value("Days", item.date,unit: .day),
                            y: .value(item.name,item.animate ? item.value : 0)
                        )
                        .foregroundStyle(Color.openGreen.gradient)
                }else{
                    BarMark(
                        x: .value("Days", item.date,unit: .day),
                        y: .value(item.name,item.animate ? item.value : 0)
                    )
                    .clipShape(RoundedRectangle(cornerRadius:30))
                    .foregroundStyle(Color.openGreen.gradient)
                }
                if let currentActive,currentActive.id == item.id{
                    RuleMark(x:.value("Day", currentActive.date,unit: .day))
                        .lineStyle(.init(lineWidth: 2,miterLimit: 2,dash: [2],dashPhase: 5))
                        .offset(x:(plotWidth / CGFloat(statsItems.count)) / 2)
                        .annotation(position: .top){
                            VStack(alignment:.leading,spacing: 6){
                                Text(currentActive.name)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(currentActive.value)")
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal,10)
                            .padding(.vertical,4)
                            .background{
                                RoundedRectangle(cornerRadius: 6,style:.continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
                }
            }
        }
        .chartYScale(domain: 0...(max + max * 0.5))
        .frame(height: 250)
        .onAppear{
            animateGraph()
        }
        .chartOverlay{proxy in
            GeometryReader{innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                let location = value.location
                                
                                if let date:Date = proxy.value(atX: location.x){
                                    let calendar = Calendar.current
                                    
                                    let day = calendar.component(.day, from: date)
                                    
                                    if let currenItem = statsItems.first(where: {item in
                                        calendar.component(.day, from: item.date) == day
                                        
                                    }){
                                        self.currentActive = currenItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded{value in
                                self.currentActive = nil
                            }
                    )
            }
        }
        
    }
    @ViewBuilder
    func entitiesList()->some View{
        VStack{
            ForEach(statsItems){item in
                entitiesListRow(item:item)
                
            }
            .listRowBackground(Color.clear)
        }
    }
    @ViewBuilder
    func entitiesListRow(item:StatsItem)->some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.shadow(.drop(radius: 2)))
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text("\(item.value.formatted())")
                        Text(item.name)
                        
                    }
                    .foregroundColor(.black)
                    Text(item.date, style: .date)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(height: 70)
    }

    
    func animateGraph(fromChange:Bool = false){
        for (index,_) in statsItems.enumerated(){
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(index) * (fromChange ? 0.03:0.05)){
                withAnimation(fromChange ? .easeInOut(duration: 0.8):.interactiveSpring(response: 0.8,dampingFraction: 0.8,blendDuration: 0.8)){
                    statsItems[index].animate = true
                }
            }
        }
    }
    func refreshStatsItems(){
        var items = [StatsItem]()
        if let days = userstore.userForApp.first?.days{
            for day in days {
                if currentTab == "Kcal"{
                    let item = StatsItem(name: "Kcal", value:Double(calculateKcals(day: day)), date: stringToDate(string: day.date))
                    items.append(item)
                }else if currentTab == "🏋️ Workout"{
                    let item = StatsItem(name: "mins", value:Double(day.workoutMinutes), date: stringToDate(string: day.date))
                    items.append(item)
                }else if currentTab == "⚖️ Weight"{
                    let item = StatsItem(name: "kg", value:day.weightOFDay, date: stringToDate(string: day.date))
                    items.append(item)
                }else{
                    let item = StatsItem(name: "ml", value:Double(day.waterIntake), date: stringToDate(string: day.date))
                    items.append(item)
                }
            }
            
        }
        withAnimation(.interactiveSpring(response: 0.8,dampingFraction: 0.8,blendDuration: 0.8)){
            statsItems = items
        }
    }
    func calculateKcals(day:Day)->Int{
        var total = 0
        for food in day.foods{
            for ingred in food.ingredients{
                total += ingred.totalNutritions["kcal"] ?? 0
            }
        }
        return total
    }
    func stringToDate(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let reverseDate = dateFormatter.date(from: string)
        return reverseDate ?? Date.now
       
    }
    func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()

        // Convert Date to String
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(UserStore())
    }
}




struct StatsItem:Identifiable{
    var id = UUID()
    let name:String
    let value:Double
    let date:Date
    var animate = false
}
