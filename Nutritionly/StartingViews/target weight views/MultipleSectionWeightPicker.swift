//
//  MultipleSectionWeightPicker.swift
//  Nutritionly
//
//  Created by aplle on 5/27/23.
//

import SwiftUI

struct MultipleSectionWeightPicker: View {
    @Binding var weightInt:Int
    @Binding var weightDouble:Int
    let doubles = Array(0...9)
    let ints = Array(30...150)
    var body: some View {
        GeometryReader{geo in
            
            HStack(alignment: .center){
                Picker("", selection: $weightInt){
                ForEach(ints ,id:\.self){num in
                    Text("\(num)")
                        
                 }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geo.size.width / 3)
            Text(".")
                Picker("", selection: $weightDouble){
                ForEach(doubles ,id:\.self){num in
                    Text("\(num)")
                        
                 }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: geo.size.width / 3)
                Text("kg")
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            
        }
    }
}

struct MultipleSectionWeightPicker_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSectionWeightPicker(weightInt: .constant(50), weightDouble: .constant(2))
    }
}
