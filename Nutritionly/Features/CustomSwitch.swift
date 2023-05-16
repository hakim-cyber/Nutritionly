//
//  CustomSwitch.swift
//  Nutritionly
//
//  Created by aplle on 5/17/23.
//

import SwiftUI
enum TypeOfAddings:CaseIterable{
    case new,recent
}

struct CustomSwitch: View {
    @Binding var typeOfadding:TypeOfAddings
    @Namespace var namespace
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .stroke(.gray,lineWidth: 1)
            HStack{
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .fill(.thinMaterial)
                    .frame(width: 150,height:50)
                    .offset(x:typeOfadding == .recent ? 150:0)
                
                    Spacer()
                
            }
            .frame(width: 300,height:50)
            
            HStack(){
                ForEach(Array(TypeOfAddings.allCases) , id:\.self){ type in
                    Spacer()
                    Text(textOFType(type:type))
                        .onTapGesture {
                            withAnimation(.spring()){
                                typeOfadding = type
                            }
                        }
                      Spacer()
                        
                        
                }
            }
           
                
            
        }
        .frame(height:50)
        .frame(width: 300)
        .padding(.horizontal,30)
        
        
    }
    func textOFType(type:TypeOfAddings)->String{
        if type == .new{
            return "New"
        }else{
            return "Recents"
        }
        
    }
}

struct CustomSwitch_Previews: PreviewProvider {
    static var previews: some View {
        CustomSwitch(typeOfadding: .constant(.new))
    }
}
