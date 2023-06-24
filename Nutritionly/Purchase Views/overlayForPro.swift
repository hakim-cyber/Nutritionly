//
//  overlayForPro.swift
//  Nutritionly
//
//  Created by aplle on 6/24/23.
//

import SwiftUI

struct overlayForPro: View {
    let width:CGFloat
    let height:CGFloat
    let cornerRadius:CGFloat
   
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.ultraThinMaterial)
                .frame(width: width,height: height)
            ProSymbol()
        }
    }
}

struct overlayForPro_Previews: PreviewProvider {
    static var previews: some View {
        overlayForPro(width: 100, height: 100,cornerRadius: 15)
    }
}
