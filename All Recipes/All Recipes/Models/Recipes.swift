//
//  Recipes.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 07/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation
struct Recipes : Codable{
    let all : [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case all = "meals"
    }
}

struct Recipe : Codable{
    let idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube,  strDrinkAlternate, strSource, strImageSource, strCreativeCommonsConfirmed, dateModified : String?
    
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20, strMeasure1,  strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20 : String?
    
    var ingredientsList : [String?]{
        var ingredients = [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20 ]
        ingredients.removeAll { value in
            return value == "" || value == nil
        }
        return ingredients
    }
    
    var ingredientsMeasureList : [String?]{
        var measure = [strMeasure1,  strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20 ]
        measure.removeAll { value in
            return value == "" || value == nil
        }
        return measure
    }
    
    var instructionsList :[String]{
        guard var components = strInstructions?.components(separatedBy: "\r\n") else { return ["No instructions found"] }
        components.removeAll { value in
            return value == ""
        }
        return components
    }
}
