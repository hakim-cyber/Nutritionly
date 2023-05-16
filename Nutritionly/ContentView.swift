//
//  ContentView.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
          MainView()
                .preferredColorScheme(.light)
                
                
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
