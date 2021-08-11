//
//  CategoryViewModel.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 09/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct CategoryListViewModel {
    let categories: [Category]
}

extension CategoryListViewModel {
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.categories.count
    }
    func categoryAtIndex(_ index: Int) -> CategoryViewModel {
        let category = self.categories[index]
        return CategoryViewModel(category)
    }
}

struct CategoryViewModel {
    private let category: Category
}

extension CategoryViewModel {
    init(_ category: Category) {
        self.category = category
    }
    var title: String {
        return self.category.strCategory
    }
    var description: String {
        return self.category.strCategoryDescription
    }
    var image:String{
        return self.category.strCategoryThumb
    }
}
