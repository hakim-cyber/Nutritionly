//
//  testSearchView.swift
//  Nutritionly
//
//  Created by aplle on 5/19/23.
//

import SwiftUI

struct testSearchView: View {
    @StateObject var model = SearchIngredientViewModel()
    var body: some View {
        VStack{
            TextField("Search",text: $model.serchText)
                .onSubmit {
                            Task{
                               await model.searchForIngred()
                            }
                }
               
            
            if model.searchResults.isEmpty {
                ProgressView()
            }else{
                List(Array(model.searchResults.indices) , id: \.self){index in
                    HStack{
                        Text("\(model.searchResults[index].description!)")
                        
                        Text("\(model.searchResults[index].filteredNutrients[3].nutrientName )")
                            .bold()
                        Text("\(Int(model.searchResults[index].filteredNutrients[3].value) ?? 0)")
                            .bold()

                        
                        }
                }
            }
            Spacer()
        }
       
      
    }
}

struct testSearchView_Previews: PreviewProvider {
    static var previews: some View {
        testSearchView()
    }
}
