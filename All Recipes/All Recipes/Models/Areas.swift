//
//  Areas.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 10/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct Areas : Codable{
    let all : [Area]
    
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

struct Area : Codable{
    let strArea : String
}
