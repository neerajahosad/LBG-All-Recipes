//
//  DataService.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 09/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation
import Alamofire

class DataService{
    func loadCategoriesAPIRequest(with url : URL,completion : @escaping ([Category]) -> ()){
        AF.request(url).validate()
            .responseDecodable(of: Categories.self) {(response) in
                if let categories = response.value {
                    completion(categories.all)
                    return
                }
        }
    }
    func loadFilterByCategoryAPIRequest(with url : URL,completion : @escaping ([FilterByCategory]) -> ()){
        AF.request(url).validate()
            .responseDecodable(of: FilterByCategories.self) {(response) in
                if let categories = response.value {
                    completion(categories.all)
                    return
                }
        }
    }
    func loadRecipesAPIRequest(with url : URL,completion : @escaping ([Recipe]) -> ()){
        AF.request(url).validate()
            .responseDecodable(of: Recipes.self) {(response) in
                if let recipes = response.value {
                    completion(recipes.all)
                    return
                }
        }
    }
    func loadAreasAPIRequest(with url : URL,completion : @escaping ([Area]) -> ()){
        AF.request(url).validate()
            .responseDecodable(of: Areas.self) {(response) in
                if let areas = response.value {
                    completion(areas.all)
                    return
                }
        }
    }
}
