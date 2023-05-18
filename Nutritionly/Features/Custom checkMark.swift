//
//  Custom checkMark.swift
//  Nutritionly
//
//  Created by aplle on 5/18/23.
//

import SwiftUI

struct CustomCheckMark: View {
    var selected:Bool
    var size:Int
    var body: some View {
        ZStack{
            if !selected{
                Circle()
                    .stroke(.gray)
            }else{
                Circle()
                    .fill(.blue)
            }
            if selected{
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .padding(2)
            }
        }
        .frame(width: CGFloat(size))
       
    }
}

struct CustomCheckMark_Previews: PreviewProvider {
    static var previews: some View {
        CustomCheckMark(selected: true,size: 30)
    }
}
