//
//  FilterCategoryViewModel.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 09/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct FilterCategoryListViewModel {
    var categoriesFilter: [FilterByCategory]
}

extension FilterCategoryListViewModel {
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.categoriesFilter.count
    }
    func categoryAtIndex(_ index: Int) -> FilterCategoryViewModel {
        let filterByCategory = self.categoriesFilter[index]
        return FilterCategoryViewModel(filterByCategory)
    }
}

struct FilterCategoryViewModel {
    private let filterByCategory: FilterByCategory
}

extension FilterCategoryViewModel {
    init(_ filterByCategory: FilterByCategory) {
        self.filterByCategory = filterByCategory
    }
    var id: String {
        return self.filterByCategory.idMeal
    }
    var title: String {
        return self.filterByCategory.strMeal
    }
    var image: String {
        return self.filterByCategory.strMealThumb
    }
}
