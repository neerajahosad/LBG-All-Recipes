//
//  Categories.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 07/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct Categories : Codable{
    let all : [Category]
    
    enum CodingKeys: String, CodingKey {
        case all = "categories"
    }
}

struct Category : Codable{
    let idCategory, strCategory, strCategoryThumb, strCategoryDescription : String
}
