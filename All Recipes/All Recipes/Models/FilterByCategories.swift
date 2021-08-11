//
//  FilterByCategories.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 08/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct FilterByCategories : Codable{
    let all : [FilterByCategory]
    
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

struct FilterByCategory : Codable{
    let strMeal, strMealThumb, idMeal : String
}
