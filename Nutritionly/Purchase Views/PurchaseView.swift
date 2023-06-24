//
//  PurchaseView.swift
//  Nutritionly
//
//  Created by aplle on 6/24/23.
//

import SwiftUI
enum PurchasePlans:CaseIterable{
    case monthly , threeMonth , yearly
}

struct PurchaseView: View {
    @AppStorage("backgroundColor") var backgroundColor = Colors.openGreen.rawValue
    
    @State private var screen = UIScreen.main.bounds
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var seletedPlan:PurchasePlans = .monthly
    var body: some View {
        ZStack{
            
            ScrollView(showsIndicators: false){
                VStack(spacing: 30){
                    HStack{
                        Text("Nutritionly Pro")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                           
                        VStack{
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("openBlue"))
                                .font(.title3)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    
                    VStack(spacing: 20){
                        HStack(spacing:15){
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("openBlue"))
                            Text("Track Daily Steps 🏃‍♀️")
                            
                            Spacer()
                        }
                        HStack(spacing:15){
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("openBlue"))
                            Text("Track Your Workout Minutes 🏋️")
                            
                            Spacer()
                        }
                        HStack(spacing:15){
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("openBlue"))
                            Text("Track Daily Water Intake 💧")
                            
                            Spacer()
                        }
                        HStack(spacing:15){
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("openBlue"))
                            Text("Acces To Food Database 🍛")
                            
                            Spacer()
                        }
                        HStack(spacing:15){
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("openBlue"))
                            Text("Acces to Background Colors 🌈")
                            
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .padding(.top)
                .padding(.horizontal)
                .padding(.leading,10)
            }
        }
        .safeAreaInset(edge: .top){
            HStack{
                Button{
                    dismiss()
                }label:{
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.leading,22)
        }
        .safeAreaInset(edge: .bottom){
            VStack(spacing: 15){
                ForEach(PurchasePlans.allCases , id:\.hashValue){plan in
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(plan == seletedPlan ? .secondary : Color.white)
                            .opacity(0.2)
                        HStack(spacing:15){
                            
                            Image(systemName: seletedPlan == plan ? "checkmark.seal.fill" : "checkmark.seal" )
                                .foregroundColor(Color("openBlue"))
                                .font(.title3)
                            if plan == .monthly{
                                Text("US$ 3.99 / Month")
                            }else if plan == .threeMonth {
                                Text("US$ 6.99 / 3 Month")
                            }else{
                                Text("US$ 12.99 / Year")
                            }
                            
                            Spacer()
                            if plan == .threeMonth{
                                Text("🎁 Save 40%")
                            }else if plan == .yearly{
                                Text("🎁 Save 70%")
                            }
                        }
                        .padding()
                        
                    }
                    .frame(width: screen.width / 1.1, height: screen.height / 15)
                    .onTapGesture {
                        self.seletedPlan = plan
                    }
                    
                }
                
                Button{
                    
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("openBlue"))
                            
                        HStack{
                            Text("Subscribe Now")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        }
                    }
                    .frame(width: screen.width / 1.15 , height: screen.height / 17)
                }
                
                Text("Automatically renews until cancelation")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .fontWeight(.light)
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
