//
//  SearchIngredViewModel.swift
//  Nutritionly
//
//  Created by aplle on 5/19/23.
//
import Alamofire
import Foundation


class SearchIngredientViewModel:ObservableObject{
    @Published var searchResults = [SearchFood]()
    @Published var serchText = ""
    
    let apiKey = "TvkbyoSdCVg1iBZXRScF0RvpqQXYGh5shgWZLPRz"
    
    func searchForIngred(text:String){
        let parameters:[String:Any] = [
            "query":text,
            "api_key":apiKey
        ]
        let url = "https://api.nal.usda.gov/fdc/v1/foods/search"
        AF.request(url,parameters: parameters)
            .validate()
            .responseDecodable(of: SearchResponse.self){response in
                switch response.result{
                case .success(let searchResponse):
                    self.searchResults = searchResponse.foods
                case .failure(let error):
                    print("Error Fetching search\(error.localizedDescription)")
                    
                }
            }
        
    }
    
    
}


struct SearchResponse:Codable{
    let foods:[SearchFood]
}

struct SearchFood:Identifiable, Codable{
    let id:Int
    let name:String
    let nutritionInfo:NutritionInfo
}
struct NutritionInfo:Codable{
    let proteins:Double
    let carbs:Double
    let fats:Double
    let calories:Int
}
