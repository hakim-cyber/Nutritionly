//
//  SearchIngredViewModel.swift
//  Nutritionly
//
//  Created by aplle on 5/19/23.
//

import Foundation
import SwiftUI
/*
 curl -X 'GET' \
   'https://api.nal.usda.gov/fdc/v1/foods/search?query=apple&dataType=&pageSize=10&pageNumber=1&api_key=TvkbyoSdCVg1iBZXRScF0RvpqQXYGh5shgWZLPRz' \
   -H 'accept: application/json'
 */


// nutrients gived in 100g size
//if yu want to know whole kcal grams * per 100g nutrients
class SearchIngredientViewModel:ObservableObject{
    @Published var searchResults =  [SearchFood]()
    @Published var serchText = ""
    
   
    let apiKey = "TvkbyoSdCVg1iBZXRScF0RvpqQXYGh5shgWZLPRz"
    

    func searchForIngred() async{
        
        if let searchQuery = serchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            
            if let url  = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(searchQuery)&dataType=&pageSize=25&pageNumber=1&api_key=TvkbyoSdCVg1iBZXRScF0RvpqQXYGh5shgWZLPRz")
{
                
                
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do{
                            let decoded = try JSONDecoder().decode(SearchResponse.self ,from: data)
                            DispatchQueue.main.async{
                                withAnimation (.easeInOut){
                                    self.searchResults = decoded.foods
                                }
                                
                            }
                            
                        }catch{
                            print(error)
                        }
                    } else if let error = error {
                        print("HTTP Request Failed \(error)")
                    }
                }

                task.resume()
                
            }else{
                print("url error")
            }
        }else{
            print("query error")
        }
    }
    
}


struct SearchFood: Codable {
    let fdcId: Int?
    let description: String?
    let foodCategory:String?
    let foodNutrients: [NutritionInfo]
    
    var filteredNutrients:[NutritionInfo]{
        foodNutrients.filter{SearchFood.neededNutrients.contains($0.nutrientNumber)}
    }
  static  let neededNutrients = ["208","203","205","204"]
   
}

struct SearchResponse: Codable {
    let foods: [SearchFood]
}

struct NutritionInfo: Codable {
    let nutrientId:Int
    let nutrientNumber:String
    let nutrientName: String
    let value:Double
    let unitName:String
}
