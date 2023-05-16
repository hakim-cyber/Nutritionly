//
//  CustomSearchBar.swift
//  Nutritionly
//
//  Created by aplle on 5/17/23.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText:String
    var color:Color
    var body: some View {
        TextField("Search ",text: $searchText)
        .padding()
        .padding(.horizontal,10)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(20)
        .shadow(color:.gray,radius: 5)
        .padding(.horizontal,10)
        .padding(.vertical,2)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(searchText: .constant(""),color:Color.openGreen)
    }
}
