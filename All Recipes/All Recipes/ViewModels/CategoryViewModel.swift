//
//  CategoryViewModel.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 09/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

protocol CategoryViewModelProtocol {
    func didUpdateCategories()
}
class CategoryViewModel: NSObject {
    var delegate: CategoryViewModelProtocol?
    fileprivate(set) var categories: [CategoryModel] = []
    
    private var dataService = DataService()
    
    func fetchCategories(){
        let all_categories_url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        dataService.loadCategoriesAPIRequest(with: URL(string: all_categories_url)!){ categories in
            self.categories = categories
            self.delegate?.didUpdateCategories()
        }
    }
}
