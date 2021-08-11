//
//  AreaViewModel.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 10/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import Foundation

struct AreaListViewModel {
    let areas: [Area]
}

extension AreaListViewModel {
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.areas.count
    }
    func areaAtIndex(_ index: Int) -> AreaViewModel {
        let area = self.areas[index]
        return AreaViewModel(area)
    }
}

struct AreaViewModel {
    private let area: Area
}

extension AreaViewModel {
    init(_ area: Area) {
        self.area = area
    }
    var title: String {
        return self.area.strArea
    }
}
