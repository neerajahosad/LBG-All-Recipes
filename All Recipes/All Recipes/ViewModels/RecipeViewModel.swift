//
//  RecipeViewModel.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 09/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct RecipeListViewModel {
    let recipes: [Recipe]
}

extension RecipeListViewModel {
    var numberOfSections: Int {
        return 2
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        if section == 0{return self.recipes[0].ingredientsList.count}
        else if section == 1{return self.recipes[0].instructionsList.count}
        return self.recipes.count
    }
    func recipeAtIndex(_ index: Int) -> RecipeViewModel {
        let recipe = self.recipes[index]
        return RecipeViewModel(recipe)
    }
}

struct RecipeViewModel {
    private let recipe: Recipe
}

extension RecipeViewModel {
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    var image: String {
        guard let imageUrl = self.recipe.strMealThumb else {return " "}
        return imageUrl
    }
    var ingredientsList: [String?] {
        return self.recipe.ingredientsList
    }
    var ingredientsMeasureList : [String?]{
        return self.recipe.ingredientsMeasureList
    }
    var instructionsList :[String]{
        return self.recipe.instructionsList
    }
}
